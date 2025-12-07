declare class Vec2
    x: number
    y: number
end

declare Vec2: {
    new: ((x: number, y: number) -> Vec2)
}


declare class Vec3
    x: number
    y: number
    z: number
end

declare Vec3: {
    new: ((x: number, y: number, z: number) -> Vec3)
}

declare class UDim
    rel: number
    rel_x: number
    rel_y: number
    inch: number
    px: number

    __add: (UDim, UDim) -> UDim
    __sub: (UDim, UDim) -> UDim
end

declare UDim: {
    new: ((px: number, inch: number, rel: number, rel_x: number, rel_y: number) -> UDim),
    px: ((px: number) -> UDim),
    inch: ((inch: number) -> UDim),
    rel: ((rel: number) -> UDim),
    rel_x: ((rel_x: number) -> UDim),
    rel_y: ((rel_y: number) -> UDim),
}

declare px: ((px: number) -> UDim)
declare inch: ((inch: number) -> UDim)
declare rel: ((rel: number) -> UDim)
declare rel_x: ((rel_x: number) -> UDim)
declare rel_y: ((rel_y: number) -> UDim)


declare class UDim2
    x: UDim
    y: UDim

    __add: (UDim2, UDim2) -> UDim2
    __sub: (UDim2, UDim2) -> UDim2
end

declare UDim2: {
    new: ((x: UDim | number, y: UDim | number) -> UDim2),
}


declare class Color
    r: number
    g: number
    b: number
end

declare Color: {
    from_rgb: ((r: number, g: number, b: number) -> Color),
    from_rgb_255: ((r: number, g: number, b: number) -> Color),
}


declare class Quat
    x: number
    y: number
    z: number
    w: number
end

declare Quat: {
    new: ((x: number, y: number, z: number, w: number) -> Quat),
    from_axis_angle: ((axis: Vec3, angle: number) -> Quat),
    from_euler_xyz: ((x: number, y: number, z: number) -> Quat),
}


declare class Material
    function set_texture(self, name: string, texture: Texture)
    function clone(self): Material
    function set_float1(self, name: string, f1: number)
    function set_float2(self, name: string, f1: number, f2: number)
    function set_float3(self, name: string, f1: number, f2: number, f3: number)
    function set_float4(self, name: string, f1: number, f2: number, f3: number, f4: number)
    function set_int1(self, name: string, i1: number)
    function set_int2(self, name: string, i1: number, i2: number)
    function set_int3(self, name: string, i1: number, i2: number, i3: number)
    function set_int4(self, name: string, i1: number, i2: number, i3: number, i4: number)
end

declare class Texture end

declare class Camera2D
    position: UDim2
    scale: UDim2
    rotation: number
    anchor: Vec2
end

-- Declare enums

declare class TextScaling end
declare class TextScalingEnums
    --- Do nothing
    None: TextScaling
    --- Only scale down to fit inside the boundaries
    Fit: TextScaling
    --- Make the text as big as possible
    Max: TextScaling
end

declare class TextAlignment end
declare class TextAlignmentEnums
    TopRight: TextAlignment
    TopMiddle: TextAlignment
    TopLeft: TextAlignment
    MiddleRight: TextAlignment
    Middle: TextAlignment
    MiddleLeft: TextAlignment
    BottomRight: TextAlignment
    BottomMiddle: TextAlignment
    BottomLeft: TextAlignment
end

declare class TextWrap end
declare class TextWrapEnums
    --- Do nothing
    None: TextWrap
    --- Wrap words
    Word: TextWrap
    --- Wrap words (glyphs if word is too long)
    WordOrGlyph: TextWrap
    --- Wrap glyphs
    Glyph: TextWrap
end

declare class TextWeight end
declare class TextWeightEnums
    Thin: TextWeight
    ExtraLight: TextWeight
    Light: TextWeight
    Normal: TextWeight
    Medium: TextWeight
    SemiBold: TextWeight
    Bold: TextWeight
    ExtraBold: TextWeight
    Black: TextWeight
end

declare class TextStretch end
declare class TextStretchEnums
    UltraCondensed: TextStretch
    ExtraCondensed: TextStretch
    Condensed: TextStretch
    SemiCondensed: TextStretch
    Normal: TextStretch
    SemiExpanded: TextStretch
    Expanded: TextStretch
    ExtraExpanded: TextStretch
    UltraExpanded: TextStretch
end

declare class SpreadMethod end
declare class SpreadMethodEnums
    Packed: SpreadMethod
    CenterAvailableSpace: SpreadMethod
    MaxSize: SpreadMethod
    MaxDistance: SpreadMethod
end

declare class TextureFormat end
declare class TextureFormatEnums
    RGBA8: TextureFormat
    RGBA16F: TextureFormat
end

declare class SideOverflowBehavior end
declare class SideOverflowBehaviorEnums
    Stretch: SideOverflowBehavior
    Shrink: SideOverflowBehavior
end

declare class AxisStretchMode end
declare class AxisStretchModeEnums
    Stretch: AxisStretchMode
    Tile: (value: UDim) -> AxisStretchMode
    TileFit: (value: UDim) -> AxisStretchMode
end

declare class Axis2D end
declare class Axis2DEnums
    X: Axis2D
    Y: Axis2D
end


declare class InteractState end
declare class InteractStateEnums
    None: InteractState
    Hovered: InteractState
    Clicked: InteractState
end

declare Enum: {
    TextScaling: TextScalingEnums,
    TextAlignment: TextAlignmentEnums,
    TextWrap: TextWrapEnums,
    TextWeight: TextWeightEnums,
    TextStretch: TextStretchEnums,
    SpreadMethod: SpreadMethodEnums,
    TextureFormat: TextureFormatEnums,
    SideOverflowBehavior: SideOverflowBehaviorEnums,
    AxisStretchMode: AxisStretchModeEnums,
    Axis2D: Axis2DEnums,
    InteractState: InteractStateEnums,
}

declare class CharEvent
    char: string
    character: string
    ctrl: boolean
    alt: boolean
    shift: boolean
    logo: boolean
    ["repeat"]: boolean
end

declare class InputEventInfo
    mouse_pos: Vec2
    scroll: Vec2
    char_events: { CharEvent }
    key_downs: { string }
    key_holds: { string }
    key_ups: { string }
    mouse_downs: { string }
    mouse_holds: { string }
    mouse_ups: { string }

    function is_mouse_primary_pressed(self): boolean
    function is_mouse_secondary_pressed(self): boolean
    function is_mouse_middle_pressed(self): boolean
    function is_mouse_unknown_pressed(self): boolean

    function is_mouse_primary_held(self): boolean
    function is_mouse_secondary_held(self): boolean
    function is_mouse_middle_held(self): boolean
    function is_mouse_unknown_held(self): boolean

    function is_mouse_primary_released(self): boolean
    function is_mouse_secondary_released(self): boolean
    function is_mouse_middle_released(self): boolean
    function is_mouse_unknown_released(self): boolean

    function is_key_pressed(self, key: string): boolean
    function is_key_held(self, key: string): boolean
    function is_key_released(self, key: string): boolean
end

declare input: InputEventInfo

-- Declare globals

declare request_render: (() -> ())
declare screen_width: number
declare screen_height: number
declare run_script: ((script: string) -> any)


type PartialActor<Self> = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,

    early_update: ((self: Self) -> ())?,
    update: ((self: Self) -> ())?,
    late_update: ((self: Self) -> ())?,
    init: ((self: Self) -> ())?,
    on_hover: ((self: Self) -> ())?,
    on_un_hover: ((self: Self) -> ())?,
    on_click: ((self: Self) -> ())?,
    on_click_release: ((self: Self) -> ())?,
    on_scroll: ((self: Self) -> ())?,
}

declare class Actor
    name: string
    enabled: boolean
    interactable: boolean
    scrollable: boolean
    hide_cursor_interaction: boolean
    parent: Actor?

    function early_update(self)
    function update(self)
    function late_update(self)
    function init(self)
    function on_hover(self)
    function on_un_hover(self)
    function on_click(self)
    function on_click_release(self)
    function on_scroll(self)
end


type PartialTransform2D = {
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
}

declare class Actor2D extends Actor
    position: UDim2
    scale: UDim2
    anchor: Vec2
    rotation: number
    snap_to_pixels: boolean

    function put_center(self)
    function push_left(self)
    function push_right(self)
    function push_top(self)
    function push_bottom(self)
end


type PartialBackgroundAppearance = {
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
}

declare class Actor2DBackground extends Actor2D
    background_color: Color
    background_hovered_color: Color
    background_clicked_color: Color
    background_transparency: number
    background_texture: Texture
    background_uv_offset: Vec2
    background_uv_scale: Vec2
    background_material: Material
end


declare class FrameActor extends Actor2DBackground
    [number]: Actor?
end
type PartialFrameActor = PartialActor<FrameActor> & PartialTransform2D & PartialBackgroundAppearance


type PartialNinePatchInfo = {
    slice_bottom: number?,
    slice_top: number?,
    slice_left: number?,
    slice_right: number?,
    size_bottom: UDim?,
    size_top: UDim?,
    size_left: UDim?,
    axis_stretch_x: AxisStretchMode?,
    axis_stretch_y: AxisStretchMode?,
    side_overflow_behavior: SideOverflowBehavior?,
    
}

declare class NinePatchFrameActor extends FrameActor
    slice_bottom: number
    slice_top: number
    slice_left: number
    slice_right: number
    size_bottom: UDim
    size_top: UDim
    size_left: UDim
    axis_stretch_x: AxisStretchMode
    axis_stretch_y: AxisStretchMode
    side_overflow_behavior: SideOverflowBehavior
end
type PartialNinePatchFrameActor = PartialActor<FrameActor> & PartialNinePatchInfo & PartialTransform2D & PartialBackgroundAppearance


type PartialLayoutInfo = {
    scroll_speed: number?,
    child_size: UDim2?,
    border_spacing: UDim2?,
    child_spacing: UDim2?,
    spread_method: SpreadMethod?,
    inch_scroll: boolean?,
    vertical_scroll: boolean?,
}

declare class ScrollFrameActor extends FrameActor
    scroll_speed: number
    child_size: UDim2
    border_spacing: UDim2
    child_spacing: UDim2
    spread_method: SpreadMethod
    inch_scroll: boolean
    vertical_scroll: boolean
end
type PartialScrollFrameActor = PartialActor<ScrollFrameActor> & PartialLayoutInfo & PartialTransform2D & PartialBackgroundAppearance


type Partial2DViewport = {
    resolution_mult: number?,
    rerender_count: number?,
    texture_format: TextureFormat?,
    double_buffer: boolean?,

    view_color: Color?,
    view_hovered_color: Color?,
    view_clicked_color: Color?,
    view_transparency: number?,
    view_texture: Texture?,
    view_uv_offset: Vec2?,
    view_uv_scale: Vec2?,
    view_material: Material?,
}

declare class TextureFrameActor extends FrameActor
    camera: Camera2D
    render_texture: Texture
    resolution_mult: number
    rerender_count: number
    texture_format: TextureFormat
    double_buffer: boolean
    view_color: Color
    view_hovered_color: Color
    view_clicked_color: Color
    view_transparency: number
    view_texture: Texture
    view_uv_offset: Vec2
    view_uv_scale: Vec2
    view_material: Material
end

type PartialTextureFrameActor = PartialActor<TextureFrameActor> & Partial2DViewport & PartialTransform2D & PartialBackgroundAppearance

declare Create: {
    frame: ((data: PartialFrameActor) -> FrameActor),
    nine_patch_frame: ((data: PartialNinePatchFrameActor) -> NinePatchFrameActor),
    texture_frame: ((data: PartialTextureFrameActor) -> TextureFrameActor),
    scroll_frame: ((data: PartialScrollFrameActor) -> ScrollFrameActor),
}

declare create_material: ((data: {
    frag: string?,
    vert: string?,
    uniforms: {any}?
}) -> Material)