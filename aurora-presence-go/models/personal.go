package models

type Personal struct {
	ID             uint   `gorm:"primaryKey"`
	Name           string `json:"name"`
	UserID         uint   `json:"userid"`
	PhoneNumber    string `json:"phone_number"`
	DateOfBirth    string `json:"date_of_birth"`
	Gender         string `json:"gender"`
	Address        string `json:"address"`
	EmergencyNumber string `json:"emergency_number"`
	EmployeeID     string `json:"employee_id"`
	Department     string `json:"department"`
	Position       string `json:"position"`
}
