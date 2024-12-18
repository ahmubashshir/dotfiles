// @pkg posix
// @pkg gio-2.0

[DBus (name = "org.freedesktop.NetworkManager.Settings", timeout = 120000)]
public interface Settings : GLib.Object
{
	[DBus (name = "NewConnection")]
	public async signal void new_connection(GLib.ObjectPath connection);

	[DBus (name = "Connections")]
	public abstract GLib.ObjectPath[] connections { owned get; }

	[DBus (name = "CanModify")]
	public abstract bool can_modify {  get; }
}

[DBus (name = "org.freedesktop.NetworkManager.Settings.Connection", timeout = 120000)]
public interface Connection : GLib.Object
{

	[DBus (name = "Update")]
	public abstract void
	update(GLib.HashTable<string, GLib.HashTable<string, GLib.Variant>> properties)
	throws DBusError, IOError;

	[DBus (name = "GetSettings")]
	public abstract GLib.HashTable<string, GLib.HashTable<string, GLib.Variant>>
	get_settings() throws DBusError, IOError;

	[DBus (name = "Save")]
	public abstract void save() throws DBusError, IOError;
}

public class IgnoreNMDHCPDNS: GLib.Application
{
		private Settings settings;

		private IgnoreNMDHCPDNS()
		{
			Object(application_id: "io.github.ahmubashshir.nm.dhcpdns.ignore", flags:
			       ApplicationFlags.HANDLES_COMMAND_LINE
			       | ApplicationFlags.ALLOW_REPLACEMENT);

			add_main_option("quit",    'q', OptionFlags.NONE, OptionArg.NONE, "Terminate service.", null);
			add_main_option("replace", 'r', OptionFlags.NONE, OptionArg.NONE, "Replace service.", null);
			startup.connect(startup_async);
		}

		public override int command_line (ApplicationCommandLine args)
		{
			base.command_line(args);

			this.hold ();
			if(args.get_options_dict().lookup_value("quit", VariantType.BOOLEAN) != null)
				quit();
			this.release ();
			return 0;
		}

		public override int handle_local_options (VariantDict opts)
		{
			base.handle_local_options(opts);

			this.hold ();
			if(opts.lookup_value("replace", VariantType.BOOLEAN) != null) {
				flags |= ApplicationFlags.REPLACE | ApplicationFlags.IS_SERVICE;
				opts.remove("replace");
			}

			this.release ();
			return -1;
		}

		private async void dhcp_ignore_auto_dns(GLib.ObjectPath path, string busaddr)
		{
			Connection conn;
			try {
				conn = yield Bus.get_proxy<Connection>(
				           BusType.SYSTEM,
				           busaddr, path, 0, null);
			} catch (Error e) {
				info(@"Error: $(e.message)\n");
				return;
			}

			try {
				var prefs = conn.get_settings();
				switch(prefs.get("connection").get("type").get_string()) {
				case "gsm":
				case "cdma":
				case "pppoe":
				case "802-3-ethernet":
				case "802-11-wireless":
					var yes = new Variant.boolean(true);
					var ip4 = (!) (prefs.get("ipv4").get("ignore-auto-dns")?.get_boolean() ?? false);
					var ip6 = (!) (prefs.get("ipv6").get("ignore-auto-dns")?.get_boolean() ?? false);
					if (! ip4)
						prefs.get("ipv4").set("ignore-auto-dns", yes);
					if (! ip6)
						prefs.get("ipv6").set("ignore-auto-dns", yes);
					if (ip4 && ip6) break;

					conn.update(prefs);
					conn.save();
					stderr.printf(@"Ignore dhcp-auto-dns on <$(
					              prefs.get("connection").get("uuid").get_string()
					             )> $(
					                 prefs.get("connection").get("id").get_string()
					             )\n");

					break;
				}
			} catch (Error e) {
				error(@"Error: $(e.message)\n");
			}
		}


		private async void startup_async()
		{
			hold();

			var busaddr = "org.freedesktop.NetworkManager";
			var objpath = "/org/freedesktop/NetworkManager/Settings";

			try {
				settings = yield Bus.get_proxy<Settings>(BusType.SYSTEM, busaddr, objpath, 0, null);
			} catch (Error e) {
				error(@"Error: $(e.message)\n");
			}

			if(! settings.can_modify) {
				error("Unmodifiable settings.");
			}

			settings.new_connection.connect((path) => dhcp_ignore_auto_dns.begin(path, busaddr));

			foreach (var path in settings.connections)
				yield dhcp_ignore_auto_dns(path, busaddr);

		}

		public static async int main(string[] args)
		{
			var app = new IgnoreNMDHCPDNS();
			return app.run(args);
		}
}
