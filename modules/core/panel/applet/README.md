As a starting boilerplate, you may use this:

```yuescript
import "awful"
import "gears"
import "wibox"
import "beautiful"

import scale, lookup_icon from "modules.lib.theme"

import "modules.core.panel.common"

export.<call> = (_, kwargs={}) ->
	with kwargs
		assert(.screen)
		assert(.config)
		assert(.helpers)

	{ :screen, :config, :helpers } = kwargs

```
