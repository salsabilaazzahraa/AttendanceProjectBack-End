package controllers

import (
	"aurora-presence-go/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetOffices(c *gin.Context) {
	var offices []models.Office
	models.DB.Find(&offices)
	c.JSON(http.StatusOK, offices)
}

func CreateOffice(c *gin.Context) {
	var office models.Office
	if err := c.ShouldBindJSON(&office); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	models.DB.Create(&office)
	c.JSON(http.StatusOK, office)
}
