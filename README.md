Element Portals
===============

A [Minetest](http://minetest.net/) mod that adds teleport capabilities in the game trough the natural elements found in the world. Portals can have a custom name and you can select your destination. The mod is separated in submodules so you can chose to use a subset of these portals.

Screnshots
----------

![Water Portal](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_water_portal.png)

![Lava portal](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_lava_portal.png)

![Tree portal](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_tree_portal.png)

![Tree portal root](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_tree_portal_root.png)

![Sand portal](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_sand_portal.png)

![Desert sand portal](https://gist.githubusercontent.com/curieuxx/0e51be3854dfb0be7358/raw/item_desert_sand_portal.png)


Usage / Wiki
------------

A wiki with pictures and details is here :  [https://github.com/curieuxx/mod-element_portals/wiki](https://github.com/curieuxx/mod-element_portals/wiki)

Dependencies
------------
Just mods found in defaults:

 - default
 - bucket
 - dye [new]


Install
-------
Download the [zip](https://github.com/curieuxx/mod-element_portals/archive/master.zip) or clone the url (so far no release)  and unpack into your mintest `mods` as described here: [Installing Mods](http://wiki.minetest.com/wiki/Installing_Mods) or here : [Installing_Mods](http://dev.minetest.net/Installing_Mods). Don't forget to enable it from world configuration.


Current portals
---------------

 * __Water portal__ uses water as connection and power, they are private and you can select your end point
 * __Lava portal__ act like water portals but use lava as connection and power
 * __Tree portal__ as home portal, the portal grows roots that can be harvested, when you need to get back home just plant the root and a link will be created to all of your tree portals where you can teleport. The planted root will slowly grow into a tree sapling after a while
 * __Sand portal__ used as fast escapes - just step on it and your on the other end


What is new in the last milestone  ?
-------------


New Portals and Nodes:

 - [Tree portals](https://github.com/curieuxx/mod-element_portals/wiki/Tree-Portals) [Implemented]
 - [Sand portals](https://github.com/curieuxx/mod-element_portals/wiki/Sand-Portals) [Implemented]
 - [Quick sand](https://github.com/curieuxx/mod-element_portals/wiki/Sand-Portals#quick-sand) needed for sand portals [Implemneted] 

 
New technical features :

 - Item portals functions [Implemented] - allows to implement tools or items that act as IN portals
 - Portal filtering by their direction types (IN_OUT, IN, OUT) and groups [Implemented]
 - Allow portals to be powered with surounding elements [implemented]
 - Other utility methods that will help for the future portal nodes [Implemented]
 - '/teleport_free' command [Implemented]
 - Sanitize portals - Checks for data and node pair, if they are not in sync then they are fixed - allows introducing new featres without needing to clear world alteration made by previous implementation [implemented]


Bufixes for existing portals : 

 - Portal name is generated with duplicates #9
 - Portal data is not syncronized with the node when burned or pulverized by tnt #10
 - Portal list from portal form contained and empty item #11
 - Overhead in register_abm for liquid portals #12
 - Double consumption on teleport #13
 - Various performance, complexity, DRY and cycle dependency fixes [ongoing]




Under development
-------------------------

   * Dirt portal - Public portal that helps you teleport to nearby players by "digging" tunnels.

   * Stone box - Doesn't teleport a player but works more or less like a locked chest but it's inventory is shared across all stone boxes.

   * Maybe a Mese portal - Expensive to craft but with all the abilities of the other portals elements. "Maybe" mainly because it may shade the other portal types.



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

Licence for textures
--------------------

Author 2014 Tiberiu Corbu

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
http://creativecommons.org/licenses/by-sa/3.0/
 
Refer to each `README.md` file from the submodules `textures` folder for licence, details about derivations from the original and original authors of individual files used.

These are :

 * [Liquid Portals Textures README.md](./liquid_portals/textures/README.md)
 * [Tree Portals Textures README.md](./tree_portals/textures/README.md)
 * [Sand Portals Textures README.md](./sand_portals/textures/README.md)

Licence for sounds
------------------

Refer to each `README.md` file from the submodules `sounds` folder for licence, details about derivations from the original and original authors of individual files used.
 
These are :

 * [Liquid Portals Sounds README.md](./liquid_portals/sounds/README.md)
 * [Tree Portals Sound README.md](./tree_portals/sounds/README.md)
 


