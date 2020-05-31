Step = RegisterBehavior("128hhGrowAgarLike")
--把文件放在sizebox behavior文件夹内
--如果有重名 自己重命名
--使用方法
--1.进入游戏 选择gts 选择playas 然后把size拉到默认大小
--2.右键自己(确定自己是play as gts模式 然后,选择Size/GrowAgarLike
--3.然后离远一点放置gts 也是调整到默认大小 
--4.自由选择比其他gts大 还是小
--5.在走路时自动判定与最近的gts 距离 和大小
--6.如果比gts小 那么自己没了 gts变大
--7.如果自己比gts大 那么gts没了 自己变大

--8.我使用了一种变向的方法来实现模拟碰到最近的gts 因为没找到碰撞检测的API

--9. beta1.0初级测试 早期测试 有能力的可以优化代码 改进代码
Step.data =  {
    menuEntry = "Size/GrowAgarLike",
    secondary = true,
    agent = {
        type = { "humanoid" }
    },
    target = {
        type = { "oneself" }
    }
}

function Step:Listener(data)
	--log(entity)
	log("step")	
	log("当前实体"..data.entity.name)
	log("当前实体id"..data.entity.id)
	log("脚"..data.foot)
	log("脚力"..data.magnitude)
	log("位置"..data.position)
	local nearest=data.entity.FindClosestGiantess()	
	if nearest then
		log("最近的gts"..nearest.name)
		log(nearest.name.."位置"..nearest.position)
		local distance=data.entity.DistanceTo(nearest)
		log("距离:"..distance)
		if distance<2 then
			if data.entity.scale>nearest.scale then
				nearest.delete()
				data.entity.Grow(0.5,1.0)
			else 
				nearest.Grow(0.5,1.0)
				data.entity.delete()
				--data.entity.crash()
				end
		
			
		end
	end
	--log(tostring(position))
	--log(tostring(magntude))
end
function Step:Start() 
	log("start")
	--log(self.agent)
	 self.agent.dict.OnStep=Event.Register(self, EventCode.OnStep, self.Listener)
	--log(tostring(self.agent.dict))
end