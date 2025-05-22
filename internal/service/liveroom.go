package service

import (
	"live_room/internal/model"
	"live_room/pkg/db"
)

type LiveRoomService struct {
}

// 查询直播间列表
func (lr *LiveRoomService) GetLiveRooms() ([]*model.LiveRoom, error) {
	var liveRoom model.LiveRoom
	liveRooms, err := liveRoom.GetLiveRooms(db.DB)
	if err != nil {
		return nil, err
	}
	return liveRooms, err
}

// 查询单个直播间详情
func (lr *LiveRoomService) GetLRDetail(id int64) (*model.LiveRoom, error) {
	var liveRoom *model.LiveRoom
	err := liveRoom.GetLiveRoomByID(db.DB, id)
	if err != nil {
		return nil, err
	}
	return liveRoom, err
}

// 查询直播间回放地址
func (lr *LiveRoomService) GetReplayUrlByID(id int64) (string, error) {
	var liveRoom model.LiveRoom
	err := liveRoom.GetLiveRoomByID(db.DB, id)
	if err != nil {
		return "", err
	}
	return liveRoom.ReplayURL, nil
}
