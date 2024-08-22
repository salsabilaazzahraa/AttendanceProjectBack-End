package models

type User struct {
	ID       uint   `gorm:"primaryKey"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (User) TableName() string {
    return "user"
}
