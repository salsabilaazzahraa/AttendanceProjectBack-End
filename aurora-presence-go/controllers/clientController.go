package controllers

import (
	"aurora-presence-go/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetClients(c *gin.Context) {
	var clients []models.Client
	models.DB.Find(&clients)
	c.JSON(http.StatusOK, clients)
}

func CreateClient(c *gin.Context) {
	var client models.Client
	if err := c.ShouldBindJSON(&client); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	models.DB.Create(&client)
	c.JSON(http.StatusOK, client)
}
