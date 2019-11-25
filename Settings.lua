--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

lastHitTimer=2*60*1000
lastHitMarkerTimer=30*1000

settings={
	general={
		version="0.0.0.5.6",
		ts3ip="lake-gaming.com",
		discordurl="https://discord.gg/AAAAAAA",
		cpurl="",
		weburl="",
		scriptname="LakeGaming",
		servername="Cops 'n' Robbers",
		servernameK="CnR",
		
		devtime=f,
		
		serverfps=100,
		nametagerange=24,
		
		guimaincolor=tocolor(40,40,40,220),
		
		teamColors={
			["Civilian"]={255,255,255},
			["Police"]={0,0,200},
			["Grove"]={0,200,0},
			["Ballas"]={130,0,150},
		},
		teamColorToHASH={
			["Civilian"]="#ffffff",
			["Police"]="#0000c8",
			["Grove"]="#00c800",
			["Ballas"]="#820096",
		},
		
		adminlvlnames={
			[6]="Developer",
			[5]="Project Leader",
			[4]="Administrator",
			[3]="Moderator",
			[2]="Supporter",
			[1]="Trial-Supporter",
			[0]="player",
		},
		adminlvlColorToHASH={
			[6]="#414141",
			[5]="#ff5555",
			[4]="#940000",
			[3]="#0097d8",
			[2]="#fcff3c",
			[1]="#ff4cee",
			[0]="#ffffff",
		},
		
		level_exp={
			[0]=150,
			[1]=300,
			[2]=550,
			[3]=750,
			[4]=1050,
			[5]=1300,
			[6]=1550,
			[7]=1800,
			[8]=2050,
			[9]=2800,
			[10]=1,
		},
	},
	teams={
		weaponprice={
			armor=100,
			stick=55,
			colt45=180,
			deagle=680,
			mp5=400,
			m4=620,
			rifle=930,
			sniper=1800,
			--Level
			stickLVL=0,
			coltLVL=0,
			deagleLVL=1,
			mp5LVL=3,
			m4LVL=5,
			rifleLVL=7,
			sniperLVL=10,
		},
	},
	systems={
		saveTimersInterval=60*1000*10,
		
		bank={
			vaultMoneyMin=200,
			vaultMoneyMax=2400,
		},
	},
	vehiclesys={
		respawntime=15
	},
	shop={
		price={
			burger=25,
		},
	},
	premiumsys={
		healprice=400
	}
}

addEventHandler("onPlayerChangeNick",getRootElement(),function()
	cancelEvent()
end)

if(not lp)then
	function infoShow(player,typ,msg,args)
		triggerClientEvent(player,"infoShow",player,typ,msg,args)
	end
end

if(not lp)then
	function notificationShow(player,typ,msg,time)
		triggerClientEvent(player,"notificationShow",player,typ,msg,time)
	end
end