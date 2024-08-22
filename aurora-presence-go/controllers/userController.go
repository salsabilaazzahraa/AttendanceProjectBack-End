package controllers

import (
	"aurora-presence-go/models"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func GetUser(c *gin.Context) {
    var user []models.User
    models.DB.Find(&user)
    c.JSON(http.StatusOK, user)
}

func CreateUser(c *gin.Context) {
    var user models.User
    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }
    models.DB.Create(&user)
    c.JSON(http.StatusOK, user)
}

func LoginUser(c *gin.Context) {
    var input models.User
    var user models.User

    log.Printf("Login attempt with email: %s and password: %s", input.Email, input.Password)

    result := models.DB.Where("email = ? AND password = ?", input.Email, input.Password).First(&user)
    if result.Error != nil {
		if result.Error == gorm.ErrRecordNotFound {
			log.Printf("User not found or invalid password with email: %s", input.Email)
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid email or password"})
		} else {
			log.Printf("Error finding user: %v", result.Error)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Internal server error"})
		}
		return
	}	

    log.Printf("User logged in successfully: %s", user.Email)
    c.JSON(http.StatusOK, gin.H{"message": "Login successful"})
}
