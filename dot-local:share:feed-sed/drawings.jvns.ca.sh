#!/bin/bash
xml ed -u '//item/description' -x 'concat('\''@LT@![CDATA['\'', .,
'\''
	@LT@picture style="padding: 0.5em;width: 100vw; min-height: 75px;"@GT@'\'',
'\''
		@LT@source type="image/svg+xml" srcset="'\'',
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
'\''" /@GT@'\'',
'\''
		@LT@source type="image/png" srcset="'\'',
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
'\''" /@GT@'\'',
'\''
		@LT@source type="image/jpeg" srcset="'\'',
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
'\''" /@GT@'\'',
'\''
		@LT@img src="https://icons.iconarchive.com/icons/iconsmind/outline/512/Error-404Window-icon.png" /@GT@
	@LT@/picture@GT@
]]@GT@'\'')' | sed 's/@LT@/</g;s/@GT@/>/g'
