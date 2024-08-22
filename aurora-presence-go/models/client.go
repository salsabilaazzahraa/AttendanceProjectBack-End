package models

import (
	"gorm.io/gorm"
)

var DB *gorm.DB

type Client struct {
	ID      uint   `gorm:"primaryKey"`
	Name    string `json:"name"`
	Address string `json:"address"`
	Phone   int    `json:"phone"`
}
