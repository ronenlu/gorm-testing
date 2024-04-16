-- Create "players" table
CREATE TABLE `players` (
  `id` integer NULL PRIMARY KEY AUTOINCREMENT,
  `created_at` datetime NULL,
  `updated_at` datetime NULL,
  `deleted_at` datetime NULL,
  `clan_id` integer NULL,
  `clan_join_date` datetime NULL,
  `tracked` numeric NULL,
  CONSTRAINT `fk_clans_clan_leader` FOREIGN KEY (`clan_id`) REFERENCES `clans` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create index "idx_players_deleted_at" to table: "players"
CREATE INDEX `idx_players_deleted_at` ON `players` (`deleted_at`);
-- Create "clans" table
CREATE TABLE `clans` (
  `id` integer NULL PRIMARY KEY AUTOINCREMENT,
  `created_at` datetime NULL,
  `updated_at` datetime NULL,
  `deleted_at` datetime NULL,
  `name` text NULL,
  `player_id` integer NULL,
  CONSTRAINT `fk_players_clan` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create index "idx_clans_deleted_at" to table: "clans"
CREATE INDEX `idx_clans_deleted_at` ON `clans` (`deleted_at`);
-- Create "filters" table
CREATE TABLE `filters` (
  `discord_channel_id` text NULL,
  `min_player_wr` real NULL,
  `days_since_last_battle` integer NULL,
  `min_num_t10` integer NULL,
  `min_num_battles` integer NULL,
  `discord_guild_id` text NULL,
  PRIMARY KEY (`discord_channel_id`)
);
-- Create "filter_tracked_player" table
CREATE TABLE `filter_tracked_player` (
  `filter_discord_channel_id` text NULL,
  `player_id` integer NULL,
  PRIMARY KEY (`filter_discord_channel_id`, `player_id`),
  CONSTRAINT `fk_filter_tracked_player_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT `fk_filter_tracked_player_filter` FOREIGN KEY (`filter_discord_channel_id`) REFERENCES `filters` (`discord_channel_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "filter_tracked_clan" table
CREATE TABLE `filter_tracked_clan` (
  `filter_discord_channel_id` text NULL,
  `clan_id` integer NULL,
  PRIMARY KEY (`filter_discord_channel_id`, `clan_id`),
  CONSTRAINT `fk_filter_tracked_clan_clan` FOREIGN KEY (`clan_id`) REFERENCES `clans` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT `fk_filter_tracked_clan_filter` FOREIGN KEY (`filter_discord_channel_id`) REFERENCES `filters` (`discord_channel_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
);
