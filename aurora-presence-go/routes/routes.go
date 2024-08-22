package routes

import (
	"aurora-presence-go/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	r.GET("/clients", controllers.GetClients)
	r.POST("/clients", controllers.CreateClient)

	r.GET("/history", controllers.GetHistory)
	r.POST("/history", controllers.CreateHistory)

	r.GET("/offices", controllers.GetOffices)
	r.POST("/offices", controllers.CreateOffice)

	//r.GET("/personal", controllers.GetPersonals)
	//r.POST("/personal", controllers.CreatePersonal)

	r.GET("/schedules", controllers.GetSchedules)
	r.POST("/schedules", controllers.CreateSchedule)

	//r.GET("/users", controllers.GetUsers)
	r.POST("/users", controllers.CreateUser)

	// Routes for schedule_team
	r.GET("/schedule_teams", controllers.GetScheduleTeams)
	r.POST("/schedule_teams", controllers.CreateScheduleTeam)
	r.GET("/schedule_teams/:id", controllers.GetScheduleTeamByID)
	r.PUT("/schedule_teams/:id", controllers.UpdateScheduleTeam)
	r.DELETE("/schedule_teams/:id", controllers.DeleteScheduleTeam)
}
