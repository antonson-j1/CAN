--START OF CODE
ch_id1 = addChannel( "FTTS1", 10, 2)
ch_id2 = addChannel( "FTTS2", 10, 2)
ch_id3 = addChannel( "FTTS3", 10, 2)
ch_id4 = addChannel( "FTTS4", 10, 2)
ch_id14 = addChannel( "STR", 10, 2)
ch_id5 = addChannel( "FL", 50, 2)
ch_id6 = addChannel( "FBPS", 50, 2)
ch_id7 = addChannel( "FR",50, 2)
ch_id8 = addChannel( "MPUAccX", 50, 2, -20, 20)
ch_id9 = addChannel( "MPUAccY", 50, 2, -20, 20)
ch_id10 = addChannel( "MPUAccZ", 50, 2, -20, 20)
ch_id11 = addChannel( "YawMPU", 50, 2, -20, 20)
ch_id12 = addChannel( "PitchMPU", 50, 2, -20, 20)
ch_id13 = addChannel( "RollMPU", 50, 2, -20, 20)
ch_id24 = addChannel( " RSTR", 50, 2)
ch_id25 = addChannel( " RL", 50, 2)
ch_id26 = addChannel(" RBPS", 50, 2)
ch_id27 = addChannel(" RR ", 50, 2)    
startLogging()
count = 0
setTickRate(100)
function onTick() 
  
 
  -- Receive a CAN message on CAN1  
  local id, ext, data = rxCAN(0)
  local id1, ext1, data1 = rxCAN(1)

  if (id == nil) then
    println('No CAN1 message received!')
  elseif (id == 0x48) then
--combining the decimal values with the integer values to get 
--final sensor data

    temp1 = data[1] + ( 0.01*data[2] )
    temp2 = data[3] + ( 0.01*data[4] )
    temp3 = data[5] + ( 0.01*data[6] )
    temp4 = data[7] + ( 0.01*data[8] )
    setChannel(ch_id1 , temp1)
    setChannel(ch_id2 , temp2)
    setChannel(ch_id3 , temp3)
    setChannel(ch_id4 , temp4)
    println('Temperatures are: ' ..temp1 ..', ' ..temp2 ..', ' ..temp3 ..', '..temp4)   

 elseif (id == 0x49) then
    str = ((100*data[1]) + ( 1*data[2] ))*(5/1024)
    fl = ((100*data[3]) + ( 1*data[4] ))*(5/1024)
    fr = ((100*data[5]) + ( 1*data[6] ))*(5/1024)
    bps = ((100*data[7]) + data[8] ) * (5/1024)
    setChannel(ch_id14 , str)
    setChannel(ch_id5 , fl)
    setChannel(ch_id6 , bps)
    setChannel(ch_id7 , fr)
    println('Readings are')
    println(' STR: ' ..str ..', FL: ' ..fl) 
    println(' FR: ' ..fr ..',BPS: ' ..bps )  

 elseif (id == 0x53) then
    accx = (data[1]-1)*0.01*data[2]
    accy = (data[3]-1)*0.01*data[4]
    accz = (data[5]-1)*0.01*data[6]
    setChannel(ch_id8 , accx)
    setChannel(ch_id9 , accy)
    setChannel(ch_id10 , accz)
    println('Acceleration')
    println('AccX: ' ..accx ..', AccY: ' ..accy ..',AccZ: ' ..accz )

 elseif (id == 0x47) then
    rstr = ((100*data[1]) + ( 1*data[2] ))*(5/1024)
    rl = ((100*data[3]) + ( 1*data[4] ))*(5/1024)
    rr = ((100*data[5]) + ( 1*data[6] ))*(5/1024)
    rbps = ((100*data[7]) + data[8] ) * (5/1024)
    setChannel(ch_id24 , rstr)
    setChannel(ch_id25 , rl)
    setChannel(ch_id26 , rbps)
    setChannel(ch_id27 , rr)
    println('Rear Readings are')
    println(' STR: ' ..rstr ..', FL: ' ..rl) 
    println(' FR: ' ..rr ..',BPS: ' ..rbps ) 

 elseif (id == 0x54) then
    if (data[1] >= 10) then
      data[2] = data[2]+255
      data[1] = data[1]-10
    end
    
    yaw = (data[1]-1)*data[2]
 
    if (data[3] >= 10) then
      data[4] = data[4]+255
      data[3] = data[3]-10
    end

    pitch = (data[3]-1)*data[4]

    if (data[5] >= 10) then
      data[6] = data[6]+255
      data[5] = data[5]-10
    end

    roll = (data[5]-1)*data[6]
    setChannel(ch_id11 , accx)
    setChannel(ch_id12 , accy)
    setChannel(ch_id13 , accz)
    println('Gyro values')
    println('Yaw: ' ..yaw ..', Pitch: ' ..pitch ..',Roll: ' ..roll )

 else
    println('Got CAN message ID: ' ..id ..' data: ' ..data[1])
    println('Got CAN message ID: ' ..id ..' data: ' ..data[2])
 end

 if (id1 == nil) then
    println('No CAN2 message received!')
 
 elseif (id1 == 0x53) then
    accx = (data[1]-1)*0.01*data[2]
    accy = (data[3]-1)*0.01*data[4]
    accz = (data[5]-1)*0.01*data[6]
    setChannel(ch_id8 , accx)
    setChannel(ch_id9 , accy)
    setChannel(ch_id10 , accz)
    println('Acceleration')
    println('AccX: ' ..accx ..', AccY: ' ..accy ..',AccZ: ' ..accz )

 elseif (id1 == 0x49) then
    rstr = ((100*data[1]) + ( 1*data[2] ))*(5/1024)
    rl = ((100*data[3]) + ( 1*data[4] ))*(5/1024)
    rr = ((100*data[5]) + ( 1*data[6] ))*(5/1024)
    rbps = ((100*data[7]) + data[8] ) * (5/1024)
    setChannel(ch_id24 , rstr)
    setChannel(ch_id25 , rl)
    setChannel(ch_id26 , rbps)
    setChannel(ch_id27 , rr)
    println('Rear Readings are')
    println(' STR: ' ..rstr ..', FL: ' ..rl) 
    println(' FR: ' ..rr ..',BPS: ' ..rbps ) 

 elseif (id1 == 0x54) then
    if (data[1] >= 10) then
      data[2] = data[2]+255
      data[1] = data[1]-10
    end
    
    yaw = (data[1]-1)*data[2]
 
    if (data[3] >= 10) then
      data[4] = data[4]+255
      data[3] = data[3]-10
    end

    pitch = (data[3]-1)*data[4]

    if (data[5] >= 10) then
      data[6] = data[6]+255
      data[5] = data[5]-10
    end

    roll = (data[5]-1)*data[6]
    setChannel(ch_id11 , accx)
    setChannel(ch_id12 , accy)
    setChannel(ch_id13 , accz)
    println('Gyro values')
    println('Yaw: ' ..yaw ..', Pitch: ' ..pitch ..',Roll: ' ..roll )
 end
end
--END OF CODE
