

local spawn_interval = 0.125

local spawn_cube_timer = 0

local cube_speed = 1
local base_cube_rot_speed = 0.4
local cube_rot_speed_spread = 0.2

local base_cube_size = 1.05
local cube_size_spread = 0.1

local mouse_influence = 2;

local spread = 1
local depth_spread = 35
local camera_depth_offset = 5
local max_depth = depth_spread + camera_depth_offset

local max_aspect_ratio = 4

function random_vec3()
    local theta = math.random() * 2 * math.pi
    local z = math.random() * 2 - 1
    local r = math.sqrt(1 - z * z)

    local x = r * math.cos(theta)
    local y = r * math.sin(theta)

    return Vec3.new(x, y, z)
end

local fog = create_material{
    frag = "fog.frag",
    textures = {"depth_tex"},
} 

local function width_at_depth(depth, aspect_ratio)
    return (spread * depth * math.min(aspect_ratio, max_aspect_ratio) + mouse_influence + 2) / 2
end

local last_aspect_ratio = 0
local last_width = 0
local delta_width = 0

local function create_random_cube(fast_forward, reference_aspect_ratio)
    local axis = random_vec3()
    local rot_time_offset = math.random() * math.pi
    local current_depth = math.random() * depth_spread;

    local total_depth = current_depth + camera_depth_offset

    local height = (math.random() - 0.5) * width_at_depth(max_depth, 1) * 2;

    local height_reference = width_at_depth(total_depth, 1);

    if math.abs(height) > height_reference then
        return
    end

    local width = width_at_depth(total_depth, reference_aspect_ratio)
    
    local current_width = width - fast_forward * cube_speed

    if current_width > width_at_depth(total_depth, screen_width / screen_height) then
        return
    end

    local current_rot_speed = base_cube_rot_speed + (math.random() - 0.5) * cube_rot_speed_spread

    local first_update = true

    local time = rot_time_offset
    
    return Create.mesh{
        init=function(self)
            self.scale *= base_cube_size + (math.random() - 0.5) * cube_size_spread
            self.position = Vec3.new(current_width, height, -current_depth)
            self.color = Color.from_rgb_255(80, 151, 252)
        end,
        late_update=function(self)
            time += delta_time
            self.rotation = Quat.from_axis_angle(axis, time * current_rot_speed)
            if first_update then
                first_update = false
                return
            end
            local width = width_at_depth(total_depth, screen_width / screen_height)

            self.position = self.position - Vec3.new(delta_time * cube_speed + math.max(delta_width, 0), 0, 0)
            if self.position.x < -width or self.position.x > width then
                self.parent = nil
            end
        end
    }
end

local cam_offset = Vec3.new(0, 0, 0)
local euler_offset = Vec3.new(0, 0, 0)
local prev_mouse_offset = Vec2.new(0, 0)

return Create.frame{
    init=function (self)
    end,
    update=function(self)
        spawn_cube_timer += delta_time
    end,
    Create.scene_3d{
        resolution_mult=2,
        init=function(self)
            self.camera.position = Vec3.new(0, 0, camera_depth_offset)

            self.view_material = fog
            self.view_material:set_texture("depth_tex", self.depth_texture)
        end,
        update=function(self)

            --[[
            if input:is_key_held("W") then
                cam_offset = cam_offset + Vec3.new(0, 0, -1) * delta_time
            end
            if input:is_key_held("S") then
                cam_offset = cam_offset + Vec3.new(0, 0, 1) * delta_time
            end
            if input:is_key_held("A") then
                cam_offset = cam_offset + Vec3.new(-1, 0, 0) * delta_time
            end
            if input:is_key_held("D") then
                cam_offset = cam_offset + Vec3.new(1, 0, 0) * delta_time
            end
            if input:is_key_held("Q") then
                cam_offset = cam_offset + Vec3.new(0, -1, 0) * delta_time
            end
            if input:is_key_held("E") then
                cam_offset = cam_offset + Vec3.new(0, 1, 0) * delta_time
            end

            if input:is_key_held("Up") then
                euler_offset = euler_offset + Vec3.new(1, 0, 0) * delta_time
            end
            if input:is_key_held("Down") then
                euler_offset = euler_offset + Vec3.new(-1, 0, 0) * delta_time
            end
            if input:is_key_held("Left") then
                euler_offset = euler_offset + Vec3.new(0, 1, 0) * delta_time
            end
            if input:is_key_held("Right") then
                euler_offset = euler_offset + Vec3.new(0, -1, 0) * delta_time
            end]]--

            local aspect_ratio = screen_width / screen_height;

            local width = width_at_depth(max_depth, aspect_ratio)
            local fast_forward_offset = 0
            delta_width =  width - last_width
            last_width = width
            if delta_width > 0 then
                fast_forward_offset =  -(delta_width / cube_speed)
                spawn_cube_timer += (delta_width / cube_speed) * 2
            end

            local normalized_mouse = input.mouse_pos / Vec2.new(screen_width, screen_height)
            local clamped_mouse = Vec2.new(math.clamp(normalized_mouse.x, 0, 1), math.clamp(normalized_mouse.y, 0, 1))
            local camera_offset = (clamped_mouse - 0.5) * mouse_influence;
            local delta_time2 = delta_time * 2
            prev_mouse_offset = prev_mouse_offset * math.max((1.0 - delta_time2), 0) + camera_offset * math.min(delta_time2, 1)
            self.camera.position = Vec3.new(prev_mouse_offset.x, prev_mouse_offset.y, camera_depth_offset) + cam_offset * 10
            self.camera.rotation = Quat.from_euler_xyz(euler_offset.x,euler_offset.y,euler_offset.z)
            while  spawn_cube_timer > spawn_interval do
                spawn_cube_timer -= spawn_interval
                local cube = create_random_cube(spawn_cube_timer + fast_forward_offset, last_aspect_ratio)
                if cube ~= nil then
                    cube.parent = self
                end
            end
            last_aspect_ratio = aspect_ratio
        end,
    },
}