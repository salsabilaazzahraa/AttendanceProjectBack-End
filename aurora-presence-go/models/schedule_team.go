package models

type ScheduleTeam struct {
	ID         uint `json:"id" gorm:"primary_key"`
	ScheduleID uint `json:"schedule_id"`
	UserID     uint `json:"user_id"`
}

func (ScheduleTeam) TableName() string {
	return "schedule_team"
}
