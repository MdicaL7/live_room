package main

import (
	"live_room/config"
	"live_room/internal/handler"
	"live_room/pkg/db"

	"github.com/gin-gonic/gin"
)

/*
主程序入口
*/

func main() {
	//初始化读取配置文件
	config.InitConfig()
	dsn := config.Conf.GetString("mysql.dsn")
	//初始化拿到db连接
	db.InitMySQL(dsn)
	defer db.CloseMySQL()
	r := gin.Default()
	liveRoom := &handler.LiveRoom{}
	//获取直播列表路由
	r.GET("/v1/api/liveRoom", liveRoom.GetLiveRooms)
	//获取单个直播
	r.GET("/v1/api/liveRoom/:id", liveRoom.GetLRDetail)
	//获取回放路由
	r.GET("/v1/api/replay", liveRoom.GetReplayUrl)
	user := &handler.User{}
	//登录
	r.POST("/v1/api/login", user.Login)

	r.Run(":8080")
}
