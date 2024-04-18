-- Create "clans" table
CREATE TABLE `clans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL,
  `updated_at` datetime(3) NULL,
  `deleted_at` datetime(3) NULL,
  `name` longtext NULL,
  `player_id` bigint NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_players_clan` (`player_id`),
  INDEX `idx_clans_deleted_at` (`deleted_at`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "filter_tracked_clan" table
CREATE TABLE `filter_tracked_clan` (
  `filter_discord_channel_id` varchar(191) NOT NULL,
  `clan_id` bigint NOT NULL,
  PRIMARY KEY (`filter_discord_channel_id`, `clan_id`),
  INDEX `fk_filter_tracked_clan_clan` (`clan_id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "filter_tracked_player" table
CREATE TABLE `filter_tracked_player` (
  `filter_discord_channel_id` varchar(191) NOT NULL,
  `player_id` bigint NOT NULL,
  PRIMARY KEY (`filter_discord_channel_id`, `player_id`),
  INDEX `fk_filter_tracked_player_player` (`player_id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "filters" table
CREATE TABLE `filters` (
  `discord_channel_id` varchar(191) NOT NULL,
  `min_player_wr` double NULL,
  `days_since_last_battle` bigint NULL,
  `min_num_t10` bigint NULL,
  `min_num_battles` bigint NULL,
  `discord_guild_id` longtext NULL,
  PRIMARY KEY (`discord_channel_id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Create "players" table
CREATE TABLE `players` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) NULL,
  `updated_at` datetime(3) NULL,
  `deleted_at` datetime(3) NULL,
  `clan_id` bigint NULL,
  `clan_join_date` datetime(3) NULL,
  `tracked` bool NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clans_clan_leader` (`clan_id`),
  INDEX `idx_players_deleted_at` (`deleted_at`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- Modify "clans" table
ALTER TABLE `clans` ADD CONSTRAINT `fk_players_clan` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "filter_tracked_clan" table
ALTER TABLE `filter_tracked_clan` ADD CONSTRAINT `fk_filter_tracked_clan_clan` FOREIGN KEY (`clan_id`) REFERENCES `clans` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, ADD CONSTRAINT `fk_filter_tracked_clan_filter` FOREIGN KEY (`filter_discord_channel_id`) REFERENCES `filters` (`discord_channel_id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "filter_tracked_player" table
ALTER TABLE `filter_tracked_player` ADD CONSTRAINT `fk_filter_tracked_player_filter` FOREIGN KEY (`filter_discord_channel_id`) REFERENCES `filters` (`discord_channel_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, ADD CONSTRAINT `fk_filter_tracked_player_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "players" table
ALTER TABLE `players` ADD CONSTRAINT `fk_clans_clan_leader` FOREIGN KEY (`clan_id`) REFERENCES `clans` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
