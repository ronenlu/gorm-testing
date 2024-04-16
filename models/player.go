package models

import (
	"time"

	"gorm.io/gorm"
)

type Player struct {
	gorm.Model
	ID           int `gorm:"primaryKey"`
	ClanID       int
	ClanJoinDate time.Time
	Clan         *Clan
	Tracked      bool
	Filters      []Filter `gorm:"many2many:filter_tracked_player;"`
}