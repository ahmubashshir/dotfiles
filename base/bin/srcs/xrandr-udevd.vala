/*
 * @compile:abi-stability
 * @compile:pkg gio-2.0
 * @compile:pkg gudev-1.0
 * @compile:pkg posix
 * @compile:pkg xcb-randr
 * @compile:pkg xcb
 * @compile:pkg x11
 * @compile:vapidir ~/Documents/vala-extra-vapis
 */

using Xcb.RandR;

public class UdevXrandr: GLib.Application
{
		private GUdev.Client         ud;
		private Xcb.Connection       xc;
		private Xcb.RandR.Connection c;

		private UdevXrandr()
		{
			Object(application_id: "io.github.ahmubashshir.udev.xrandr", flags:
			       ApplicationFlags.HANDLES_COMMAND_LINE
			       | ApplicationFlags.ALLOW_REPLACEMENT);

			add_main_option("quit",    'q', OptionFlags.NONE, OptionArg.NONE, "Terminate service.", null);
			add_main_option("replace", 'r', OptionFlags.NONE, OptionArg.NONE, "Replace service.", null);
		}

		private void disable_outputs()
		{
			foreach(var s in c.get_setup().screens) {
				var rc = c.get_screen_resources_current_reply(
				             c.get_screen_resources_current(s.root));
				foreach(var o in rc.outputs) {
					var rs = c.get_output_info_reply(
					             c.get_output_info(o, 0));
					if (rs.connection == ConnectionState.CONNECTED || rs.crtc == 0)
						continue;
					if(! disable_output(rs.crtc))
//					stderr.printf(@"$(rs.name): disconnected.\n");
//				else
						stderr.printf(@"$(rs.name): clean-up failed.\n");
				}
			}
		}

		private bool disable_output(Crtc t)
		{
			var ct = c.get_crtc_info_reply(
			             c.get_crtc_info(t, 0));
			if (ct == null)
				return false;

			var cf = c.set_crtc_config_reply(
			             c.set_crtc_config(
			                 t,
			                 (uint32) ct.timestamp,
			                 0, 0, 0,
			                 Xcb.AtomEnum.NONE,
			                 Rotation.ROTATE_0, {}
			             ));
			if (cf == null) return false;
			return true;
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

		public override void startup()
		{
			base.startup();

			hold();
			const string drm[] = {"drm"};
			ud = new GUdev.Client(drm);
			xc = new Xcb.Connection();
			c  = get_connection(xc);
			ud.uevent.connect(disable_outputs);
			disable_outputs();
		}

		public static int main(string[] args)
		{
			var app = new UdevXrandr();
			return app.run(args);
		}
}
