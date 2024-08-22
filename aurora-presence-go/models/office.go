package models

type Office struct {
	ID      uint   `gorm:"primaryKey"`
	Name    string `json:"name"`
	Address string `json:"address"`
}
