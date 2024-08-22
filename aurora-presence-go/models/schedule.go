package models

import "time"

// Struct Schedule yang sudah diperbaiki dengan nama tabel spesifik
type Schedule struct {
	ID           int       `gorm:"primaryKey"`
	Name         string    `json:"title"`
	DatetimeStart time.Time `json:"datetime_start"`
	DatetimeEnd   time.Time `json:"datetime_end"`
	ClientID     int       `json:"client_id"`
	OfficeID     int       `json:"office_id"`
}

// Memberi tahu GORM nama tabel yang tepat
func (Schedule) TableName() string {
	return "dbo.schedule"
}
