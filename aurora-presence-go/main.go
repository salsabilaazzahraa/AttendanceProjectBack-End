package main

import (
	"aurora-presence-go/models"
	"aurora-presence-go/routes"
	"log"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
)

func main() {
	dsn := "sqlserver://sa:mauraallexa@127.0.0.1:1433?database=aurora"
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database: ", err)
	}
	err = database.AutoMigrate(
		&models.Client{},
		&models.History{},
		&models.Office{},
		&models.Personal{},
		&models.Schedule{},
		&models.ScheduleTeam{},
		&models.User{},
	)
	if err != nil {
		log.Fatal("Failed to migrate database: ", err)
	}

	models.DB = database
	r := gin.Default()
	routes.SetupRoutes(r)
	r.Run(":8080")
}
