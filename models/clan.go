package models

import "gorm.io/gorm"

type Clan struct {
	gorm.Model
	ID         int `gorm:"primaryKey"`
	Name       string
	Players    []*Player `gorm:"-"`
	PlayerIDs  []int     `gorm:"-"`
	ClanLeader *Player
	PlayerID   int
	Filters    []Filter `gorm:"many2many:filter_tracked_clan;"`
}