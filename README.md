[Shifty's Hitbox](https://www.roblox.com/library/14275532358/Shiftys-Hitbox) Touched Event Replace


## DESCRIPTION
Shifty's Hitbox is a Hitbox Module that i create to replace Touched Event because it was affecting performance.
This Module is free to use, no need to credit me if u don't want ;)

## USAGES
this Hitbox modules only has 3 Functions for now `new()`, `Connect()`, and `Stop()`
we'll start from the new()

### HitboxModule.new(table)
this Function is to create a new Hitbox that will running until it reach its limit or stopped.
```lua
local hitboxModule -- Shifty Hitbox requiring
hitboxModule.new({
  Type : number = -- 1 : Create a Hitbox with the given CFrame and Size\n 2 : Create a Hitbox with the given BasePart
  Activation : number = -- 1 : Hitbox will always active\n 2 : Hitbox only active once
  Ignore : table = -- table of ignore
  Object : BasePart = -- BasePart of the Hitbox [Hitbox type 2]
  Size : Vector3 = -- Size of the Hitbox [Hitbox type 1]
  CFrame : CFrame = -- Position and Rotation of the Hitbox in CFrame [Hitbox type 1]
})
```
### HitboxModule:Connect(function)
this Function will connect the Created Hitbox with the given Function
```lua
local hitbox -- Created hitbox
hitbox:Connect(function(Object)
    print(`{Object.Name} hit me!`)
end)
```
### HitboxModule:Stop()
this Function is,,, it's obvious right?? ok no, it will stop the current connect function
```lua
local hitbox -- Created hitbox
hitbox:Stop()
```
