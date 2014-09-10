Element Portals
===============

A [Minetest](http://minetest.net/) mod that adds teleport capabilities in the game trough the natural elements found in the world. Portals can have a custom name and you can select your destination. The mod is separated in submodules so you can chose to use a subset of these portals.

What is new ?
-------------

Bufixes for existing portals : 

 - Portal name is generated with duplicates [fixed]
 - Portal data is not syncronized with the node when burned or pulverized by tnt [fixed]
 - Portal list from portal form contained and empty item [fixed]
 - Overhead in register_abm for liquid portals [fixed]
 - Double consumption on teleport [fixed]
 - Various performance, complexity, DRY and cycle dependency fixes [ongoing]

New Features:

 - Sanitize portals - Checks for data and node pair, if they are not in sync then they are fixed - allows introducing new featres without needing to clear world alteration made by previous implementation [implemented]
 - Allow portals to be powered with surounding elements [implemented]
 - Tree portals [Implemented]
 - Sand portals [Implemented]
 - Quick sand needed for sand portals [Implemneted] 
 - Item portals functions [Implemented] - allows to implement tools or items that act as IN portals
 - Portal filtering by their direction types (IN_OUT, IN, OUT) and groups [Implemented]
 - Other utility methods that will help for the future portal nodes [Implemented]
 - '/teleport_free' command [Implemented]


 
Dependencies
------------
Just mods found in defaults:

 - default
 - bucket
 - dye [new]


Install
-------
Download the [zip](https://github.com/curieuxx/mod-element_portals/archive/master.zip) or clone the url (so far no release)  and unpack into your mintest `mods` as described here: [Installing Mods](http://wiki.minetest.com/wiki/Installing_Mods) or here : [Installing_Mods](http://dev.minetest.net/Installing_Mods). Don't forget to enable it from world configuration.

Usage / Wiki
------------

A wiki with pictures and details is here :  [https://github.com/curieuxx/mod-element_portals/wiki](https://github.com/curieuxx/mod-element_portals/wiki)


Current portals
---------------

 * __Water portal__ uses water as connection and power, they are private and you can select your end point
 * __Lava portal__ act like water portals but use lava as connection and power
 * __Tree portal__ as home portal, the portal grows roots that can be harvested, when you need to get back home just plant the root and a link will be created to all of your tree portals where you can teleport. The planted root will slowly grow into a tree sapling after a while
 * __Sand portal__ used as fast escapes - just step on it and your on the other end

Under development
-------------------------


 * __Tree portal__ <strike> as home portal, the portal grows a tree from which you can take branches and use later to get back home</strike>
 * __Dirt portals__ for short distance public use


Licence
-------

Copyright 2014 Tiberiu Corbu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Licence for media files (textures and sounds)
----------------------------------------------

Copyright 2014 Tiberiu Corbu

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
http://creativecommons.org/licenses/by-sa/3.0/
 
Reffer to each `README.md` file from the submodules `textures` folder for licence, details about derivations from the original and original authors of individual files used.

These are :

 * [Liquid Portals Textures README.md](./liquid_portals/textures/README.md)
 * [Tree Portals Textures README.md](./tree_portals/textures/README.md)
 * [Sand Portals Textures README.md](./sand_portals/textures/README.md)

