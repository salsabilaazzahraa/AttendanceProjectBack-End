package controllers

import (
	"aurora-presence-go/models"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetScheduleTeams(c *gin.Context) {
	var scheduleTeams []models.ScheduleTeam
	if err := models.DB.Find(&scheduleTeams).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, scheduleTeams)
}

func CreateScheduleTeam(c *gin.Context) {
	var input models.ScheduleTeam
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := models.DB.Create(&input).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, input)
}

func GetScheduleTeamByID(c *gin.Context) {
	id := c.Param("id")
	var scheduleTeam models.ScheduleTeam
	if err := models.DB.Where("id = ?", id).First(&scheduleTeam).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Schedule team not found"})
		return
	}
	c.JSON(http.StatusOK, scheduleTeam)
}

func UpdateScheduleTeam(c *gin.Context) {
	id := c.Param("id")
	var scheduleTeam models.ScheduleTeam
	if err := models.DB.Where("id = ?", id).First(&scheduleTeam).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Schedule team not found"})
		return
	}

	var input models.ScheduleTeam
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	models.DB.Model(&scheduleTeam).Updates(input)
	c.JSON(http.StatusOK, scheduleTeam)
}

func DeleteScheduleTeam(c *gin.Context) {
	id := c.Param("id")
	var scheduleTeam models.ScheduleTeam
	if err := models.DB.Where("id = ?", id).First(&scheduleTeam).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Schedule team not found"})
		return
	}

	models.DB.Delete(&scheduleTeam)
	c.JSON(http.StatusOK, gin.H{"data": "Schedule team deleted"})
}
