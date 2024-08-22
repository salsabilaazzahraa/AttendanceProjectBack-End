package controllers

import (
	"aurora-presence-go/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetHistory(c *gin.Context) {
	var histories []models.History
	models.DB.Find(&histories)
	c.JSON(http.StatusOK, histories)
}

func CreateHistory(c *gin.Context) {
	var history models.History
	if err := c.ShouldBindJSON(&history); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	models.DB.Create(&history)
	c.JSON(http.StatusOK, history)
}
