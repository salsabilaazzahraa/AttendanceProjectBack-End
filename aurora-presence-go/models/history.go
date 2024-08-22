package models

import "time"

type History struct {
	ID         uint      `gorm:"primaryKey"`
	UserID     uint      `json:"user_id"`
	ScheduleID uint      `json:"schedule_id"`
	OfficeID   uint      `json:"office_id"`
	DateTime   time.Time `json:"date_time"`
	Type       string    `json:"type"`
}
