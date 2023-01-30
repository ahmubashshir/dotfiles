#!/bin/bash
STYLE="padding: 0.5em; min-height: 175px;"
xml ed -u '//item/description' -x 'concat('\''@LT@![CDATA['\'', .,
'\''
	@LT@object aria-role="image" style="'"$STYLE"'width: 96vw;" data="'\'',
		concat(
			ancestor::channel/link,
			'\''drawings/'\'',
			substring-before(
				substring-after(
					ancestor::item/link,
					ancestor::channel/link
				),
				'\''/'\''
			),
			'\''.svg'\''
		),
'\''" type="image/svg+xml"@GT@
		@LT@object aria-role="image" style="'"$STYLE"'width: 95vw;" data="'\'',
			concat(
				ancestor::channel/link,
				'\''drawings/'\'',
				substring-before(
					substring-after(
						ancestor::item/link,
						ancestor::channel/link
					),
					'\''/'\''
				),
				'\''.png'\''
			),
'\''" type="image/png"@GT@
			@LT@object aria-role="image" style="'"$STYLE"'width: 95vw;" data="'\'',
				concat(
					ancestor::channel/link,
					'\''drawings/'\'',
					substring-before(
						substring-after(
							ancestor::item/link,
							ancestor::channel/link
						),
						'\''/'\''
					),
					'\''.jpeg'\''
				),
'\''" type="image/jpeg"@GT@
			@LT@/object@GT@
		@LT@/object@GT@
	@LT@/object@GT@
]]@GT@'\'')' | sed 's/@LT@/</g;s/@GT@/>/g;s/jpeg\.jpeg/jpeg/g'
