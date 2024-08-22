package controllers

import (
	"aurora-presence-go/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func GetSchedules(c *gin.Context) {
	var schedules []models.Schedule
	// Menjalankan query ke tabel dbo_schedule
	models.DB.Find(&schedules)
	c.JSON(http.StatusOK, schedules)
}

func CreateSchedule(c *gin.Context) {
	var schedule models.Schedule
	if err := c.ShouldBindJSON(&schedule); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	// Menyimpan data ke tabel dbo_schedule
	models.DB.Create(&schedule)
	c.JSON(http.StatusOK, schedule)
}
