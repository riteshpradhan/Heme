-- @Author: Ritesh Pradhan
-- @Date:   2016-04-15 19:18:17
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 00:08:07


CollisionFilters = {};
CollisionFilters.enemyBullet= { categoryBits = 8, maskBits = 3};
CollisionFilters.playerBullet= { categoryBits = 2, maskBits = 28};
CollisionFilters.enemy= { categoryBits = 4, maskBits = 3};
CollisionFilters.player= { categoryBits = 1, maskBits = 508};
CollisionFilters.refill= { categoryBits = 32, maskBits = 1};
CollisionFilters.ground= { categoryBits = 256, maskBits = 1};
CollisionFilters.obstruction= { categoryBits = 16, maskBits = 3};
CollisionFilters.collectible= { categoryBits = 128, maskBits = 1};
CollisionFilters.powerup= { categoryBits = 64, maskBits = 1};
return CollisionFilters


