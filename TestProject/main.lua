function love.load()
    
    wf = require 'Libraries/windfield'
    world = wf.newWorld(0,1000)

    Camera = require 'Libraries/camera'
    camera = Camera()
    
    sti = require 'Libraries/sti'
    GameMap = sti('Maps/TestMap..lua')

    player = {}
    player.collider = world:newBSGRectangleCollider(400, 250, 22, 34, 0)
    player.collider:setFixedRotation(true)  
    player.x = 400
    player.y = 250
    player.speed = 100
    player.sprite = love.graphics.newImage('sprites/sprit.png')

    local wall = world:newRectangleCollider (100, 200, 120, 300)
    wall: setType('static')
end

function love.update(dt)

    local vx = 0
    local vy = 0
    

    if love.keyboard.isDown("left") then  
        vx = -player.speed 
    end  
    if love.keyboard.isDown("right") then  
        vx = player.speed
    end  
    if love.keyboard.isDown("up") then  
        vy = -player.speed
    end  
    if love.keyboard.isDown("down") then  
        vy = player.speed  
    end 

    player.collider:setLinearVelocity(vx,vy)

    camera:lookAt(player.x, player.y)

    world:update(dt)
    
    player.x = player.collider:getX() - 11
    player.y = player.collider:getY() - 17
end

function love.draw()

    camera:attach()
        GameMap:drawLayer(GameMap.layers["Слой тайлов 1"]) 
        love.graphics.draw(player.sprite, player.x, player.y,nil,0.1) 
        world:draw()
    camera:detach()
    
    --love.graphics.print(player.x,200,100)
    --love.graphics.print(player.y,400,100)

    --love.graphics.print(player.collider:getX(),200,200)
    --love.graphics.print(player.collider:getY(),400,200)
end