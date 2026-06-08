/*
 * @pkg gtk4
 * @-g
 */

using GLib;
using Gdk;

public class Contents : Gdk.ContentProvider
{
		private string copy = "";
		private string uris = "";
		private ContentFormats fmts;

		public Contents()
		{
			Object();

			var cfb = new Gdk.ContentFormatsBuilder();
			cfb.add_mime_type("text/uri-list");
			cfb.add_mime_type("x-special/gnome-copied-files");
			fmts = cfb.to_formats();
		}

		public void update(File[] files)
		{
			var ub = new StringBuilder();
			var cb = new StringBuilder("copy");

			foreach (var f in files) {
				ub.append(f.get_uri());
				ub.append("\r\n");

				cb.append_c('\n');
				cb.append(f.get_uri());
			}

			uris = ub.str;
			copy = cb.str;

			content_changed.emit();
		}

		public override Gdk.ContentFormats ref_formats()
		{
			return fmts.@ref();
		}

		public override async bool
		write_mime_type_async(string type, OutputStream @out, int prio, Cancellable? stopper) throws Error {
			if (! fmts.contain_mime_type(type))
			throw new IOError.NOT_SUPPORTED(@"Unsupported mime type: $type");

			string payload = ((type == "text/uri-list")?uris:copy).dup();

			yield @out.write_all_async(payload.data, prio, stopper, null);
			return true;
		}
}

public class PathClip : GLib.Application
{
	private Gdk.Display display = null;
	private Contents contents = null;

	private PathClip()
		{
			Object(
			    application_id: "io.github.ahmubashshir.pathclip",
			    flags:
			    ApplicationFlags.HANDLES_OPEN
			    | ApplicationFlags.ALLOW_REPLACEMENT);

			add_main_option("quit",	'q', OptionFlags.NONE, OptionArg.NONE, "Terminate service.", null);
			add_main_option("replace", 'r', OptionFlags.NONE, OptionArg.NONE, "Replace service.", null);

			set_option_context_parameter_string("<file...>");
		}

		protected override void startup()
		{
			Gtk.init();

			base.startup();

			var quit_action = new SimpleAction("quit", null);
			quit_action.activate.connect(quit);
			add_action(quit_action);
			display = Gdk.Display.get_default();
			contents = new Contents();

			hold();
		}

		public override int handle_local_options(VariantDict opts)
		{
			if(opts.contains("replace")) {
				flags |= ApplicationFlags.REPLACE | ApplicationFlags.IS_SERVICE;
				opts.remove("replace");
			}

			if (opts.contains("quit")) {
				try {
					register();
					activate_action("quit", null);
				} catch (Error e) {
					stderr.printf("@Error: $(e.message)\n");
				}
				return 0;
			}
			return -1;
		}

		public override void open(File[] paths, string hint)
		{
			if (display == null) return;

			var clipboard = display.get_clipboard();


			contents.update(paths);

			clipboard.set_content(contents);
		}

		protected override void activate() {}

		public static int main(string[] args)
		{

			var app = new PathClip();
			if (args.length < 2)
				return app.run({args[0], "--help"});

			return app.run(args);
		}
}
