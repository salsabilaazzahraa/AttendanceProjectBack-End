package controllers

import (
	"database/sql"
	"net/http"
	"github.com/gin-gonic/gin"
)

var db *sql.DB

// SetDB sets the database connection
func SetDB(database *sql.DB) {
	db = database
}

// GetPersonalInfo handles GET requests to retrieve personal information by ID
func GetPersonalInfo(c *gin.Context) {
	id := c.Param("id")
	var personal Personal
	err := db.QueryRow("SELECT id, name, userid, phone_number, date_of_birth, gender, address, emergency_number, employee_id, departement, position FROM personal WHERE id = ?", id).Scan(
		&personal.ID,
		&personal.Name,
		&personal.UserID,
		&personal.PhoneNumber,
		&personal.DateOfBirth,
		&personal.Gender,
		&personal.Address,
		&personal.EmergencyNumber,
		&personal.EmployeeID,
		&personal.Department,
		&personal.Position,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(http.StatusNotFound, gin.H{"error": "Personal info not found"})
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		}
		return
	}
	c.JSON(http.StatusOK, personal)
}

// CreatePersonalInfo handles POST requests to create new personal information
func CreatePersonalInfo(c *gin.Context) {
	var personal Personal
	if err := c.BindJSON(&personal); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err := db.Exec("INSERT INTO personal (name, userid, phone_number, date_of_birth, gender, address, emergency_number, employee_id, departement, position) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
		personal.Name,
		personal.UserID,
		personal.PhoneNumber,
		personal.DateOfBirth,
		personal.Gender,
		personal.Address,
		personal.EmergencyNumber,
		personal.EmployeeID,
		personal.Department,
		personal.Position,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Personal information created successfully"})
}

// UpdatePersonalInfo handles PUT requests to update personal information by ID
func UpdatePersonalInfo(c *gin.Context) {
	id := c.Param("id")

	var personal Personal
	if err := c.BindJSON(&personal); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	_, err := db.Exec("UPDATE personal SET name = ?, userid = ?, phone_number = ?, date_of_birth = ?, gender = ?, address = ?, emergency_number = ?, employee_id = ?, departement = ?, position = ? WHERE id = ?",
		personal.Name,
		personal.UserID,
		personal.PhoneNumber,
		personal.DateOfBirth,
		personal.Gender,
		personal.Address,
		personal.EmergencyNumber,
		personal.EmployeeID,
		personal.Department,
		personal.Position,
		id,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Personal information updated successfully"})
}

// DeletePersonalInfo handles DELETE requests to delete personal information by ID
func DeletePersonalInfo(c *gin.Context) {
	id := c.Param("id")

	_, err := db.Exec("DELETE FROM personal WHERE id = ?", id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Personal information deleted successfully"})
}

// Personal struct
type Personal struct {
	ID              int    `json:"id"`
	Name            string `json:"name"`
	UserID          int    `json:"userid"`
	PhoneNumber     string `json:"phone_number"`
	DateOfBirth     string `json:"date_of_birth"`
	Gender          string `json:"gender"`
	Address         string `json:"address"`
	EmergencyNumber string `json:"emergency_number"`
	EmployeeID      string `json:"employee_id"`
	Department      string `json:"departement"`
	Position        string `json:"position"`
}
