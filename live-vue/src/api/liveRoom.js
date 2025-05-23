import axios from "./axios";

//获取单个直播间详情
export function getLiveRoomDetail(id){
    return axios.get(`/v1/api/liveRoom/${id}`)
}
