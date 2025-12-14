declare class Camera2D
    position: UDim2
    scale: UDim2
    rotation: number
    anchor: Vec2
end

declare class Color
    r: number
    g: number
    b: number
end

declare Color: {
    from_rgb: ((r: number, g: number, b: number) -> Color),
    from_rgb_255: ((r: number, g: number, b: number) -> Color),
}

declare request_render: (() -> ())
declare screen_width: number
declare screen_height: number
declare delta_time: number
declare load_screen: (texture_path: string) -> ()
declare get_window_position: () -> Vec2

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

declare create_material: (data: {
    frag: string?,
    vert: string?,
    uniforms: {any}?
}) -> Material

declare class Mesh
end

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

declare class Texture end

declare load_texture: (texture_path: string) -> Texture

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

declare class Vec2
    x: number
    y: number
    function __div(self, rhs: Vec2)
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

--- 
declare class Axis2D end
--- 
declare class Axis2DEnums
    --- 
    X: Axis2D
    --- 
    Y: Axis2D
end

--- 
declare class AxisStretchMode end
--- 
declare class AxisStretchModeEnums
    --- 
    Stretch: AxisStretchMode
    --- 
    Tile: (value: UDim) -> AxisStretchMode
    --- 
    TileFit: (value: UDim) -> AxisStretchMode
end

--- 
declare class InteractState end
--- 
declare class InteractStateEnums
    --- 
    None: InteractState
    --- 
    Clicked: InteractState
    --- 
    Hovered: InteractState
end

--- 
declare class MeshType end
--- 
declare class MeshTypeEnums
    --- 
    Cube: MeshType
    --- 
    SubdividedCube: (subdivisions: number) -> MeshType
    --- 
    UvSphere: (slices: number, stacks: number) -> MeshType
end

--- 
declare class SideOverflowBehavior end
--- 
declare class SideOverflowBehaviorEnums
    --- 
    Stretch: SideOverflowBehavior
    --- 
    Shrink: SideOverflowBehavior
end

--- 
declare class SpreadMethod end
--- 
declare class SpreadMethodEnums
    --- 
    Packed: SpreadMethod
    --- 
    CenterAvailableSpace: SpreadMethod
    --- 
    MaxSize: SpreadMethod
    --- 
    MaxDistance: SpreadMethod
end

--- 
declare class TextAlignment end
--- 
declare class TextAlignmentEnums
    --- 
    TopRight: TextAlignment
    --- 
    TopMiddle: TextAlignment
    --- 
    TopLeft: TextAlignment
    --- 
    MiddleRight: TextAlignment
    --- 
    Middle: TextAlignment
    --- 
    MiddleLeft: TextAlignment
    --- 
    BottomRight: TextAlignment
    --- 
    BottomMiddle: TextAlignment
    --- 
    BottomLeft: TextAlignment
end

--- Describes how text should be scaled
declare class TextScaling end
--- Describes how text should be scaled
declare class TextScalingEnums
    --- Do nothing
    None: TextScaling
    --- Only scale down to fit inside the boundaries
    Fit: TextScaling
    --- Make the text as big as possible
    Max: TextScaling
end

--- 
declare class TextStretch end
--- 
declare class TextStretchEnums
    --- 
    UltraCondensed: TextStretch
    --- 
    ExtraCondensed: TextStretch
    --- 
    Condensed: TextStretch
    --- 
    SemiCondensed: TextStretch
    --- 
    Normal: TextStretch
    --- 
    SemiExpanded: TextStretch
    --- 
    Expanded: TextStretch
    --- 
    ExtraExpanded: TextStretch
    --- 
    UltraExpanded: TextStretch
end

--- 
declare class TextureFormat end
--- 
declare class TextureFormatEnums
    --- 
    RGBA8: TextureFormat
    --- 
    RGBA16F: TextureFormat
end

--- 
declare class TextWeight end
--- 
declare class TextWeightEnums
    --- 
    Thin: TextWeight
    --- 
    ExtraLight: TextWeight
    --- 
    Light: TextWeight
    --- 
    Normal: TextWeight
    --- 
    Medium: TextWeight
    --- 
    SemiBold: TextWeight
    --- 
    Bold: TextWeight
    --- 
    ExtraBold: TextWeight
    --- 
    Black: TextWeight
end

--- 
declare class TextWrap end
--- 
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

declare Enum: {
    --- 
    Axis2D: Axis2DEnums,
    --- 
    AxisStretchMode: AxisStretchModeEnums,
    --- 
    InteractState: InteractStateEnums,
    --- 
    MeshType: MeshTypeEnums,
    --- 
    SideOverflowBehavior: SideOverflowBehaviorEnums,
    --- 
    SpreadMethod: SpreadMethodEnums,
    --- 
    TextAlignment: TextAlignmentEnums,
    --- Describes how text should be scaled
    TextScaling: TextScalingEnums,
    --- 
    TextStretch: TextStretchEnums,
    --- 
    TextureFormat: TextureFormatEnums,
    --- 
    TextWeight: TextWeightEnums,
    --- 
    TextWrap: TextWrapEnums,
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
    function is_a(self, type: string | "Actor3D" | "MeshActor" | "Actor2D" | "Scene3D" | "FrameActor" | "NinePatchFrameActor" | "ScrollFrameActor" | "TextureFrameActor" | "TextLabelActor" | "NPTextLabelActor"): boolean
end

declare class Actor3D extends Actor
    position: Vec3
    scale: Vec3
    rotation: Quat
    function is_a(self, type: string | "MeshActor"): boolean
end

type PartialMeshActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: MeshActor)  -> ())?,
    update: ((self: MeshActor)  -> ())?,
    late_update: ((self: MeshActor)  -> ())?,
    init: ((self: MeshActor)  -> ())?,
    on_hover: ((self: MeshActor)  -> ())?,
    on_un_hover: ((self: MeshActor)  -> ())?,
    on_click: ((self: MeshActor)  -> ())?,
    on_click_release: ((self: MeshActor)  -> ())?,
    on_scroll: ((self: MeshActor)  -> ())?,
    position: Vec3?,
    scale: Vec3?,
    rotation: Quat?,
    color: Color?,
    hovered_color: Color?,
    clicked_color: Color?,
    transparency: number?,
    texture: Texture?,
    uv_offset: Vec2?,
    uv_scale: Vec2?,
    material: Material?,
    mesh: Mesh?,
}

declare class MeshActor extends Actor3D
    color: Color
    hovered_color: Color
    clicked_color: Color
    transparency: number
    texture: Texture
    uv_offset: Vec2
    uv_scale: Vec2
    material: Material
    mesh: Mesh
    function is_a(self, type: string): boolean
end

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
    background_color: Color
    background_hovered_color: Color
    background_clicked_color: Color
    background_transparency: number
    background_texture: Texture
    background_uv_offset: Vec2
    background_uv_scale: Vec2
    background_material: Material
    function is_a(self, type: string | "Scene3D" | "FrameActor" | "NinePatchFrameActor" | "ScrollFrameActor" | "TextureFrameActor" | "TextLabelActor" | "NPTextLabelActor"): boolean
end

type PartialScene3D = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: Scene3D)  -> ())?,
    update: ((self: Scene3D)  -> ())?,
    late_update: ((self: Scene3D)  -> ())?,
    init: ((self: Scene3D)  -> ())?,
    on_hover: ((self: Scene3D)  -> ())?,
    on_un_hover: ((self: Scene3D)  -> ())?,
    on_click: ((self: Scene3D)  -> ())?,
    on_click_release: ((self: Scene3D)  -> ())?,
    on_scroll: ((self: Scene3D)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    [number]: Actor3D?,
}

declare class Scene3D extends Actor2D
    [number]: Actor3D
    function insert_child(self, child_actor: Actor3D, index: number?)
    function find_child(self, child_name: string): Actor3D?
    function is_a(self, type: string): boolean
end

type PartialFrameActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: FrameActor)  -> ())?,
    update: ((self: FrameActor)  -> ())?,
    late_update: ((self: FrameActor)  -> ())?,
    init: ((self: FrameActor)  -> ())?,
    on_hover: ((self: FrameActor)  -> ())?,
    on_un_hover: ((self: FrameActor)  -> ())?,
    on_click: ((self: FrameActor)  -> ())?,
    on_click_release: ((self: FrameActor)  -> ())?,
    on_scroll: ((self: FrameActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    [number]: Actor2D?,
}

declare class FrameActor extends Actor2D
    [number]: Actor2D
    function insert_child(self, child_actor: Actor2D, index: number?)
    function find_child(self, child_name: string): Actor2D?
    function is_a(self, type: string | "NinePatchFrameActor" | "ScrollFrameActor" | "TextureFrameActor"): boolean
end

type PartialNinePatchFrameActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: NinePatchFrameActor)  -> ())?,
    update: ((self: NinePatchFrameActor)  -> ())?,
    late_update: ((self: NinePatchFrameActor)  -> ())?,
    init: ((self: NinePatchFrameActor)  -> ())?,
    on_hover: ((self: NinePatchFrameActor)  -> ())?,
    on_un_hover: ((self: NinePatchFrameActor)  -> ())?,
    on_click: ((self: NinePatchFrameActor)  -> ())?,
    on_click_release: ((self: NinePatchFrameActor)  -> ())?,
    on_scroll: ((self: NinePatchFrameActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    [number]: Actor2D?,
    slice_bottom: number?,
    slice_top: number?,
    slice_left: number?,
    slice_right: number?,
    size_bottom: UDim?,
    size_top: UDim?,
    size_left: UDim?,
    size_right: UDim?,
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
    size_right: UDim
    axis_stretch_x: AxisStretchMode
    axis_stretch_y: AxisStretchMode
    side_overflow_behavior: SideOverflowBehavior
    function is_a(self, type: string): boolean
end

type PartialScrollFrameActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: ScrollFrameActor)  -> ())?,
    update: ((self: ScrollFrameActor)  -> ())?,
    late_update: ((self: ScrollFrameActor)  -> ())?,
    init: ((self: ScrollFrameActor)  -> ())?,
    on_hover: ((self: ScrollFrameActor)  -> ())?,
    on_un_hover: ((self: ScrollFrameActor)  -> ())?,
    on_click: ((self: ScrollFrameActor)  -> ())?,
    on_click_release: ((self: ScrollFrameActor)  -> ())?,
    on_scroll: ((self: ScrollFrameActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    [number]: Actor2D?,
    scroll_speed: number?,
    inch_scroll: boolean?,
    vertical_scroll: boolean?,
    child_size: UDim2?,
    border_spacing: UDim2?,
    child_spacing: UDim2?,
    spread_method: SpreadMethod?,
}

declare class ScrollFrameActor extends FrameActor
    scroll_speed: number
    inch_scroll: boolean
    vertical_scroll: boolean
    child_size: UDim2
    border_spacing: UDim2
    child_spacing: UDim2
    spread_method: SpreadMethod
    function is_a(self, type: string): boolean
end

type PartialTextureFrameActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: TextureFrameActor)  -> ())?,
    update: ((self: TextureFrameActor)  -> ())?,
    late_update: ((self: TextureFrameActor)  -> ())?,
    init: ((self: TextureFrameActor)  -> ())?,
    on_hover: ((self: TextureFrameActor)  -> ())?,
    on_un_hover: ((self: TextureFrameActor)  -> ())?,
    on_click: ((self: TextureFrameActor)  -> ())?,
    on_click_release: ((self: TextureFrameActor)  -> ())?,
    on_scroll: ((self: TextureFrameActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    [number]: Actor2D?,
    resolution_mult: number?,
    rerender_count: number?,
    texture_format: TextureFormat?,
    double_buffer: boolean?,
    view_color: Color?,
    view_hovered_color: Color?,
    view_clicked_color: Color?,
    view_transparency: number?,
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
    view_uv_offset: Vec2
    view_uv_scale: Vec2
    view_material: Material
    function is_a(self, type: string): boolean
end

type PartialTextLabelActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: TextLabelActor)  -> ())?,
    update: ((self: TextLabelActor)  -> ())?,
    late_update: ((self: TextLabelActor)  -> ())?,
    init: ((self: TextLabelActor)  -> ())?,
    on_hover: ((self: TextLabelActor)  -> ())?,
    on_un_hover: ((self: TextLabelActor)  -> ())?,
    on_click: ((self: TextLabelActor)  -> ())?,
    on_click_release: ((self: TextLabelActor)  -> ())?,
    on_scroll: ((self: TextLabelActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    text: string?,
    text_color: Color?,
    emoji_color: Color?,
    caret_color: Color?,
    text_material: Material?,
    emoji_material: Material?,
    caret_material: Material?,
    font_size: UDim?,
    line_height_em: number?,
    padding_top_em: number?,
    padding_bottom_em: number?,
    font_family: string?,
    text_alignment: TextAlignment?,
    text_scaling: TextScaling?,
    text_wrap: TextWrap?,
    text_weight: TextWeight?,
    text_stretch: TextStretch?,
    editable: boolean?,
}

declare class TextLabelActor extends Actor2D
    text: string
    text_color: Color
    emoji_color: Color
    caret_color: Color
    text_material: Material
    emoji_material: Material
    caret_material: Material
    font_size: UDim
    line_height_em: number
    padding_top_em: number
    padding_bottom_em: number
    font_family: string
    text_alignment: TextAlignment?
    text_scaling: TextScaling
    text_wrap: TextWrap
    text_weight: TextWeight
    text_stretch: TextStretch
    editable: boolean
    function is_a(self, type: string | "NPTextLabelActor"): boolean
end

type PartialNPTextLabelActor = {
    name: string?,
    enabled: boolean?,
    interactable: boolean?,
    scrollable: boolean?,
    hide_cursor_interaction: boolean?,
    early_update: ((self: NPTextLabelActor)  -> ())?,
    update: ((self: NPTextLabelActor)  -> ())?,
    late_update: ((self: NPTextLabelActor)  -> ())?,
    init: ((self: NPTextLabelActor)  -> ())?,
    on_hover: ((self: NPTextLabelActor)  -> ())?,
    on_un_hover: ((self: NPTextLabelActor)  -> ())?,
    on_click: ((self: NPTextLabelActor)  -> ())?,
    on_click_release: ((self: NPTextLabelActor)  -> ())?,
    on_scroll: ((self: NPTextLabelActor)  -> ())?,
    position: UDim2?,
    scale: UDim2?,
    anchor: Vec2?,
    rotation: number?,
    snap_to_pixels: boolean?,
    background_color: Color?,
    background_hovered_color: Color?,
    background_clicked_color: Color?,
    background_transparency: number?,
    background_texture: Texture?,
    background_uv_offset: Vec2?,
    background_uv_scale: Vec2?,
    background_material: Material?,
    text: string?,
    text_color: Color?,
    emoji_color: Color?,
    caret_color: Color?,
    text_material: Material?,
    emoji_material: Material?,
    caret_material: Material?,
    font_size: UDim?,
    line_height_em: number?,
    padding_top_em: number?,
    padding_bottom_em: number?,
    font_family: string?,
    text_alignment: TextAlignment?,
    text_scaling: TextScaling?,
    text_wrap: TextWrap?,
    text_weight: TextWeight?,
    text_stretch: TextStretch?,
    editable: boolean?,
    slice_bottom: number?,
    slice_top: number?,
    slice_left: number?,
    slice_right: number?,
    size_bottom: UDim?,
    size_top: UDim?,
    size_left: UDim?,
    size_right: UDim?,
    axis_stretch_x: AxisStretchMode?,
    axis_stretch_y: AxisStretchMode?,
    side_overflow_behavior: SideOverflowBehavior?,
}

declare class NPTextLabelActor extends TextLabelActor
    slice_bottom: number
    slice_top: number
    slice_left: number
    slice_right: number
    size_bottom: UDim
    size_top: UDim
    size_left: UDim
    size_right: UDim
    axis_stretch_x: AxisStretchMode
    axis_stretch_y: AxisStretchMode
    side_overflow_behavior: SideOverflowBehavior
    function is_a(self, type: string): boolean
end

declare Create: {
    mesh: ((data: PartialMeshActor) -> MeshActor),
    scene_3d: ((data: PartialScene3D) -> Scene3D),
    frame: ((data: PartialFrameActor) -> FrameActor),
    nine_patch_frame: ((data: PartialNinePatchFrameActor) -> NinePatchFrameActor),
    scroll_frame: ((data: PartialScrollFrameActor) -> ScrollFrameActor),
    texture_frame: ((data: PartialTextureFrameActor) -> TextureFrameActor),
    text_label: ((data: PartialTextLabelActor) -> TextLabelActor),
    np_text_label: ((data: PartialNPTextLabelActor) -> NPTextLabelActor),
}

