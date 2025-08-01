package game

import "core:c"
import "core:math"
import str "core:strings"

import rl "vendor:raylib"

Key :: enum
{
  NONE = 0,   // No key
  PURPOSE,    // PLayer finds out their purpose
  PROFESSION, // Player learns about their own profession
  YARON,      // Player asks the store owner for his name
  SMOOCH,     // Player smooches Yaron
  NOT_CHEF,   // Player is NOT a chef by day, vampire hunter by night
  DONT_KNOW,  // Player doesn't know what they want to know
  NEED,       // Player learns that they NEED to know what they want to know
  NOTHING,    // Player learns that they seek to know nothing
  ANY         // Player has unlocked any one of the keys
}

Face :: enum
{
  NEUTRAL,
  ATTENTIVE,
  INDIFFERENT,
  ANNOYED,
  ANGRY,
  SOLEMN,
  FLUSTERED,
  HAPPY,
  ECSTATIC
}

Option :: struct
{
  key: Key,       // Key needed to ba able to see/pick this option
  next: i8,       // The line that follows this choice
  text: cstring   // Text displayed as the option
}

Line :: struct
{
  key: Key,       // Key unlocked by getting this line
  face: Face,     // Face displayed when this line is printed
  next: i8,       // LINE that follows after this one (if none, -1)
  options: [2]i8, // OPTIONS made available by this line (if none, -1 eachr)
  text: cstring   // Text displayed when getting this line
}

// Combination of line + option. Used for the log only
LineOpt :: struct
{
  line: i8,       // Index of the corresponding line
  option: i8      // Index of the corresponding option
}

WINDOW_WIDTH :: 640
WINDOW_WIDTH_HALF :: WINDOW_WIDTH / 2

// The colors assigned to each key
key_colors: [Key]rl.Color =
{
  .NONE = rl.WHITE,
  .PURPOSE = rl.GREEN,
  .PROFESSION = rl.PURPLE,
  .YARON = rl.LIME,
  .SMOOCH = rl.RED,
  .NOT_CHEF = rl.PINK,
  .DONT_KNOW = rl.YELLOW,
  .NEED = rl.ORANGE,
  .NOTHING = rl.SKYBLUE,
  .ANY = rl.WHITE
}

// Strings used more than once
STR_ASSIST: cstring: "Welcome to the Information Emporium. How may I aid you?"
STR_UNKNOWN: cstring: "(???)"
STR_CONTINUE:   cstring: "(Continue.)"
STR_SILENT: cstring: "(Say nothing.)"
STR_FINISH:    cstring: "This isn't what I meant... Ah, whatever! Let's finish this."

// Starting pair of options (used multiple times, hence why it's here)
OPT_START: [2]i8: { 29, 0 }

// Lines displayed before the main loop
intro_lines: []cstring =
{
  "(The Information Emporium lies ahead.)",
  "(You've waited long for this.)",
  "(You hope its owner is able to relay a wish.)",
  "(Speech is taxed. For free, you may speak ten words.)"
}

// Lines said by what's his name
lines: []Line =
{
          /* KEY          FACE        NEXT  OPTIONS    TEXT */
/*  0 */  { .NONE,       .NEUTRAL,     -1,  OPT_START, STR_ASSIST },
/*  1 */  { .NONE,       .ATTENTIVE,   -1, {  1, 21 }, "Well? What is it? Do you need knowledge or not?" },
/*  2 */  { .NONE,       .ATTENTIVE,   -1, {  2, 12 }, "Confused? About what? I may not aid you this way." },
/*  3 */  { .NONE,       .ATTENTIVE,   -1, {  3,  4 }, "Yourself, you say? What's this consciousness gap that ails you?" },
/*  4 */  { .PURPOSE,    .INDIFFERENT, -1,  OPT_START, "Why, I assume you're here in search of information, sir." },
/*  5 */  { .NONE,       .INDIFFERENT, -1, {  5,  7 }, "Why would you hope that I know of your identity?" },
/*  6 */  { .NONE,       .INDIFFERENT, -1, {  6, -1 }, "Does it surprise you that I ignore a nobody's existence?" },
/*  7 */  { .NONE,       .FLUSTERED,   -1, {  8, 10 }, "Indeed, you've kissed my lips. Perhaps I do know something..." },
/*  8 */  { .PROFESSION, .ATTENTIVE,   -1, {  9, -1 }, "This is a mere guess: you look like a rajnathician." },
/*  9 */  { .NONE,       .ATTENTIVE,   10, { -1, -1 }, "Your name, I believe it is..." },
/* 10 */  { .NONE,       .SOLEMN,      -1, { 11, -1 }, "Sorry, I ignore it." },
/* 11 */  { .NONE,       .ATTENTIVE,   -1, { 13, 16 }, "Could you really not know of me, the Information Curator?" },
/* 12 */  { .YARON,      .NEUTRAL,     -1, { 14, 15 }, "My name is Yaron, Does this satisfy your curiosity, seeker?" },
/* 13 */  { .NONE,       .ANNOYED,     -1,  OPT_START, "I won't further entertain this! CAN I HELP YOU, SIR?" },
/* 14 */  { .NONE,       .ANNOYED,     -1, { 17, 25 }, "Knowing who I am, you don't know what I am?" },
/* 15 */  { .NONE,       .ANGRY,       -1, { 18, 19 }, "... THUMB! YES, I'M A THUMB. Any other new, creative remarks?" },
/* 16 */  { .NONE,       .SOLEMN,      -1, { 20, 27 }, "Oh that's-! Excuse me, I... am feeling self-conscious today." },
/* 17 */  { .NONE,       .ANNOYED,     -1, { 22, 23 }, "Sir, kindly observe the line of seekers awaiting behind you." },
/* 18 */  { .NONE,       .ANGRY,       -1, { 24,  0 }, "Dear seeker: HAVE YOU ANY NEED FOR MY ASSISTANCE TODAY?" },
/* 19 */  { .NONE,       .ANGRY,       -1, { 25, 26 }, "I'd stop asking, if you's start providing answers to me!" },
/* 20 */  { .NONE,       .ATTENTIVE,   21, { -1, -1 }, "You caught me. I'm..." },
/* 21 */  { .NONE,       .SOLEMN,      -1, { 27, 28 }, "Just lonely, sometimes. That's all." },
/* 22 */  { .SMOOCH,     .FLUSTERED,   23, { -1, -1 }, "Oh, my!. I didn't expect this level of... kindness, sir." },
/* 23 */  { .NONE,       .NEUTRAL,      0, { -1, -1 }, "Alright, enough sidetracking. Let's return to the matter at hand:" },
/* 24 */  { .NONE,       .ANNOYED,     -1,  OPT_START, "Hmph. Ask something, before I decide to have you escorted." },

/* 25 */  { .NONE,       .ATTENTIVE,   -1, { 30, 31 }, "Really now? What is this profession of yours then, seeker?" },
/* 26 */  { .NOT_CHEF,   .INDIFFERENT, -1, {  6, -1 }, "Sir, no offense, but you do not seem that cool." },
/* 27 */  { .NONE,       .ANNOYED,     -1, { 32, 33 }, "Then you must be a time-waster? If not, what?" },
/* 28 */  { .NONE,       .INDIFFERENT, -1,  OPT_START, "You should practice the art of silence some more, seeker." },
/* 29 */  { .NONE,       .ATTENTIVE,   30, { -1, -1 }, "I see. That's... evident now." },
/* 30 */  { .NONE,       .NEUTRAL,     -1, { 34, 35 }, "Then, what do rajnathicians do?" },
/* 31 */  { .DONT_KNOW,  .INDIFFERENT, 30, { -1, -1 }, "No one knows what you do. Not even yourself, sir." },
/* 32 */  { .NONE,       .NEUTRAL,     33, { -1, -1 }, "Indeed? Well...," },
/* 33 */  { .NONE,       .NEUTRAL,     -1, { 36, 41 }, "Rajnathician, you are alright. What do you seek?" },
/* 34 */  { .NONE,       .INDIFFERENT, -1, { 37, 38 }, "That's not how this works. You must know your need." },
/* 35 */  { .NEED,       .NEUTRAL,     -1, { 37, 38 }, "I didn't say that. You must know what you NEED." },
/* 36 */  { .NONE,       .ATTENTIVE,   37, { -1, -1 }, "Very well. I'll reveal that knowledge, in exchange for this:" },
/* 37 */  { .NONE,       .ATTENTIVE,   -1, { 39, 40 }, "The only truth that matters--tell me: what's my name?" },
/* 38 */  { .NONE,       .INDIFFERENT, 39, { -1, -1 }, "If that's the case, I cannot, fulfill this information trade." },
/* 39 */  { .NONE,       .INDIFFERENT, -1,  OPT_START, "You must pry deeper. Then, you may achieve your goal." },
/* 40 */  { .NONE,       .NEUTRAL,     41, { -1, -1 }, "It's Yaron, actually. But close enough. I will tell you now:" },
/* 41 */  { .NOTHING,    .INDIFFERENT, 33, { -1, -1 }, "What you, sir, want to know, is nothing but nothing." },

/* 42 */  { .NONE,       .ECSTATIC,    43, { -1, -1 }, "Finally! With this knowledge, you may inherit the one true fact." },
/* 43 */  { .NONE,       .HAPPY,       44, { -1, -1 }, "This truth, which has been passed down through generations past...," },
/* 44 */  { .NONE,       .ECSTATIC,    45, { -1, -1 }, "... way, way back. Ever since the days of my father..." },
/* 45 */  { .NONE,       .HAPPY,       46, { -1, -1 }, "... (who's 63, still alive and well, living in South America!)..." },
/* 46 */  { .NONE,       .ECSTATIC,    -1, { 42, -1 }, "..., I will reveal it to you, and it'll be great!" },
/* 47 */  { .NONE,       .HAPPY,       48, { -1, -1 }, "Really! This is such precious knowledge, nobody else knows it." },
/* 48 */  { .NONE,       .ECSTATIC,    -1, { 43, -1 }, "By seeking nothing, you gain it all! You winner :)." },
/* 49 */  { .NONE,       .ATTENTIVE,   50, { -1, -1 }, "By no means! I'll tell you. But you must promise." },
/* 50 */  { .NONE,       .ATTENTIVE,   -1, { 44, 45 }, "Promise to speak this fact only once in your lifetime!" },
/* 51 */  { .NONE,       .ANGRY,       50, { -1, -1 }, "It's too late! You must accept this yoke upon yourself." },
/* 52 */  { .NONE,       .HAPPY,       53, { -1, -1 }, "Perfect! I will proceed to convey this truth to you." },
/* 53 */  { .NONE,       .ATTENTIVE,   -1, { 46, 47 }, "But before that, do you have any questions regarding this?" },
/* 54 */  { .NONE,       .ATTENTIVE,   55, { -1, -1 }, "From the beginning, you say? You do you, I guess..." },
/* 55 */  { .NONE,       .NEUTRAL,     57, { -1, -1 }, STR_ASSIST },
/* 56 */  { .NONE,       .HAPPY,       -1, { 48, 48 }, "A choice? Sure! For old time's sake, here's a choice, friend!" },
/* 57 */  { .NONE,       .HAPPY,       58, { -1, -1 }, "Hehe! Just a quick, healthy joke as the end approaches!" },
/* 58 */  { .NONE,       .ECSTATIC,    99, { -1, -1 }, "The one, precious, final truth is that you..." }
                                                                                                    // ...  are a dummy!
}

// Lines said by the player
options: []Option =
{
        /*  KEY        NEXT TEXT */
/*  0 */ { .NONE,        1, STR_SILENT },
/*  1 */ { .NONE,        2, "Excuse me. Just now, for no reason, I felt confused." },
/*  2 */ { .NONE,        3, "I'm confused about MYSELF. There's a thing I don't understand." },
/*  3 */ { .NONE,        4, "What's my PURPOSE here? Rather, what should I be doing?" },
/*  4 */ { .PURPOSE,     5, "Now I know my purpose. Yet again, WHO am I?" },
/*  5 */ { .NONE,        6, "The owner of the INFORMATION EMPORIUM would have to know!" },
/*  6 */ { .NONE,       23, "(Yikes.)" },
/*  7 */ { .SMOOCH,      7, "I appeal to the platonic smooch I gave you earlier." },
/*  8 */ { .NONE,        8, "Great! Then, I'd like to know... what is my profession?" },
/*  9 */ { .NONE,       23, "(A what?)" },
/* 10 */ { .NONE,        9, "Do you know my name? Do I even have one?" },
/* 11 */ { .NONE,       23, "(Shucks.)" },
/* 12 */ { .NONE,       11, "I'm confused about YOU. Could you broaden my knowledge, please?" },
/* 13 */ { .NONE,       12, "Yes. Let's see: In a general sense, WHO are you?" },
/* 14 */ { .NONE,       13, "What's your blood-type? ID? Do you have car insurance?" },
/* 15 */ { .NONE,       23, "Quite! You've quenched my thirst for knowledge. Not really, but-" },
/* 16 */ { .NONE,       14, "No, I know who you are. WHAT are you, sir?" },
/* 17 */ { .NONE,       15, "It's a matter of taxonomy. You seem to be a..." },
/* 18 */ { .NONE,       13, "Well, now that you ask, you also seem to be..." },
/* 19 */ { .NONE,       16, "I meant to say 'a very buff, handsome man'! Jeez!" },
/* 20 */ { .NONE,       13, "Well, if you insist, and now that you mention it...," },
/* 21 */ { .NONE,       17, STR_SILENT },
/* 22 */ { .NONE,        2, "I have. And I am sorry. I think I'm confused." },
/* 23 */ { .NONE,       18, STR_SILENT },
/* 24 */ { .NONE,       19, "Why do you ask so much? That's not your job!" },
/* 25 */ { .NONE,       23, "Uh... Oh yeah! Heheheh. Forget about it then, info-man!" },
/* 26 */ { .ANY,        20, "No, that's not true. I've replied plenty, to no avail!" },
/* 27 */ { .NONE,       22, "(Smooch him.)" },
/* 28 */ { .NONE,       24, "Psch... Deal with it. Will you help me or not?" },

/* 29 */ { .PURPOSE,    25, "I'm here to inquire for information dear to my profession." },
/* 30 */ { .NONE,       26, "Why, I'm a world-renowed gourmet chef, just passing by!" },
/* 31 */ { .NOT_CHEF,   27, "I am... not a world-renowed chef, just passing by?" },
/* 32 */ { .NONE,       28, "Excuse me, I actually don't know what my profession is." },
/* 33 */ { .PROFESSION, 29, "I guess I am a rajnathician, whatever that may be." },
/* 34 */ { .NONE,       31, "We seek forbidden knowledge hoping to attain the final truth." },
/* 35 */ { .DONT_KNOW,  32, "I don't know. In fact, I dont care to know." },
/* 36 */ { .NONE,       34, "I want you to tell me what I want, actually." },
/* 37 */ { .NONE,       35, "You can't help determine my need, then? Is that it?" },
/* 38 */ { .NEED,       36, "Then I NEED to know what I want. Pretty please?" },
/* 39 */ { .NONE,       38, "I shall tell you. Your name is: I don't know." },
/* 40 */ { .YARON,      40, "Oh, I know this one! Your name is... Yorlan, right?" },
/* 41 */ { .NOTHING,    42, "I seek nothing. Maybe just to waste your dear time." },

/* 42 */ { .NONE,       47, "Wow, really? I'm so excited, I can't say anything else!" },
/* 43 */ { .NONE,       49, "I feel like we're stalling now. We ARE stalling, right?" },
/* 44 */ { .NONE,       51, "You know what? This is starting to sound kinda lame." },
/* 45 */ { .NONE,       52, "I hereby solemnly promise to never reveal this funky truth." },
/* 46 */ { .NONE,       54, "Ley's just end this already! I'm beginning to get impatient!" },
/* 47 */ { .NONE,       56, "Do I even get a choice in this, like before?" },
/* 48 */ { .NONE,       57, STR_FINISH },

/* 49 */ { .NONE,       -1, STR_CONTINUE } // Ugly workaround necessary for the log
}

// Spaghetti-core function; draws a box and then prints a string, wrapping it to
// two lines if the text surpasses the maximum-allowed character width
// Parameters:
//  font:           font to be used
//  text:           string of text to be printed
//  text_color:     color of the text
//  max_col_width:  max amount of characters allowed per line (pre-calculated)
//  parent_width:   width in pixels of the "container" the box is drawn within
//  rect_padding:   padding taken into consideration when drawing the box
//  text_padding:   padding taken into consideration when drawing the text
draw_text_box :: proc(font: rl.Font, text: cstring, text_color: rl.Color,
  pos: rl.Vector2, parent_width: f32, rect_padding: f32, text_padding: f32,
  max_col_width: i32, color: rl.Color) -> f32 
{
  // these represent the dimsneions for the box itself
  width := parent_width - (rect_padding * 2)
  height := cast(f32)font.baseSize + (text_padding * 2)

  // this is the string of text that will eventually be drawn on screen
  printed_text := text

  // if the lenght of the text surpasses the allowed character width
  if cast(i32)len(text) > max_col_width
  {
    // extract the first line, ensuring that it ends in a space
    l1_string, ok1 := str.substring_to(cast(string)text, cast(int)max_col_width)
    if false == ok1 
    { }
    l1_end := str.last_index(l1_string, " ")
    l1_string, ok1 = str.substring_to(l1_string, l1_end)
    if false == ok1 
    { }

    // extract the second line, starting where the first line ended
    l2_string, ok2 := str.substring_from(cast(string)text, l1_end + 1)
    if false == ok2
    { }

    // raylib requires the use of cstrings
    l1 := str.clone_to_cstring(l1_string)
    l2 := str.clone_to_cstring(l2_string)
    defer delete(l1)
    defer delete(l2)

    printed_text = rl.TextFormat("%s\n%s", l1, l2)

    // by having two lines, the height is doubled
    height *= 2
  }

  // draw the box
  rl.DrawRectangleRoundedLinesEx(
    { pos.x + rect_padding, pos.y + rect_padding, width, height },
    0.2,
    0,
    1,
    color)

  // draw the text
  rl.DrawTextEx(
    font,
    printed_text,
    pos + rect_padding + text_padding,
    cast(f32)font.baseSize,
    0,
    text_color)

  return height
}

// Draw the title in a nice little black rectangle
draw_title :: proc(font: rl.Font)
{
  rl.DrawRectangle(WINDOW_WIDTH_HALF, 0, WINDOW_WIDTH_HALF, 64, rl.BLACK)
  rl.DrawTextEx(
    font,
    "The Information Emporium",
    { WINDOW_WIDTH_HALF + 12, 12 },
    cast(f32)font.baseSize,
    0,
    rl.WHITE)
}

is_vector2_within_rectangle :: proc(v: rl.Vector2, r: rl.Rectangle) -> b8
{
  return (r.x <= v.x && v.x <= (r.x + r.width)) &&
         (r.y <= v.y && v.y <= (r.y + r.height))
}

run: bool

key_set: bit_set[Key]

lineopt_buffer: [3]LineOpt

fps :: 30
vfps :: 15
vfps_freq :: fps / vfps
vfps_counter: int

font16: rl.Font
font30: rl.Font

bg_txr: rl.Texture
fg_txr: rl.Texture
face_txrs: [Face]rl.Texture

option_indent :: 12
text_box_padding :: 12
text_padding :: 4
font16_max_col_width: i32

options_y: [2]f32
options_h: [2]f32
options_hover: [2]b8

screen_state: enum{ TITLE, INTRO, GAME }

is_typing: b8
typed_characters: int

line_index: i8

init :: proc() {

	run = true

  key_set = { .NONE }

  lineopt_buffer = { { -1, -1 }, { -1, -1 }, { -1, -1 } }

  rl.InitWindow(WINDOW_WIDTH, ((WINDOW_WIDTH / 4) * 3), "The Information Emporium")

  rl.SetTargetFPS(cast(i32)fps)
  vfps_counter = 0

  font16 = rl.LoadFontEx("assets/fonts/DOS-V_re_ANK16.ttf", 16, nil, 0)
  font30 = rl.LoadFontEx("assets/fonts/DOS-V_re_ANK30.ttf", 30, nil, 0)

  bg_txr = rl.LoadTexture("assets/img/bg.png")
  fg_txr = rl.LoadTexture("assets/img/fg.png")
  face_txrs[.NEUTRAL] = rl.LoadTexture("assets/img/face/neutral.png")
  face_txrs[.ATTENTIVE] = rl.LoadTexture("assets/img/face/attentive.png")
  face_txrs[.INDIFFERENT] = rl.LoadTexture("assets/img/face/indifferent.png")
  face_txrs[.ANNOYED] = rl.LoadTexture("assets/img/face/annoyed.png")
  face_txrs[.ANGRY] = rl.LoadTexture("assets/img/face/angry.png")
  face_txrs[.SOLEMN] = rl.LoadTexture("assets/img/face/solemn.png")
  face_txrs[.FLUSTERED] = rl.LoadTexture("assets/img/face/flustered.png")
  face_txrs[.HAPPY] = rl.LoadTexture("assets/img/face/happy.png")
  face_txrs[.ECSTATIC] = rl.LoadTexture("assets/img/face/ecstatic.png")

  options_hover = { false, false }

  font16_max_col_width = cast(i32)math.trunc(
                            (WINDOW_WIDTH_HALF - (text_padding * 2) - 
                              (text_box_padding * 2)) / 
                            font16.recs[0].width)

  screen_state = .TITLE

  is_typing = true
  typed_characters = 1

  line_index = 0
}

update :: proc() {

  switch screen_state
  {
  case .TITLE:

    rl.BeginDrawing()

      rl.ClearBackground(rl.BLACK)

      // Beautiful
      rl.DrawTextEx(
        font16,
        "Credits\n\tRaylib\n\t\t- Raysan\n\t\t\thttps://www.raylib.com\n\tFonts\n\t\t- VileR: DOS/V re. ANK16 & ANK30\n\t\t\thttps://int10h.org/\n\t\t\toldschool-pc-fonts\n\tWeb implementation (it just works)\n\t\t- Karl Zylinski:\n\t\t\thttps://github.com/\n\t\t\tkarl-zylinski/odin-raylib-web\n\nThis game was made for the O2A2 VN\nJam 2025, a micro Visual Novel jam\nwith strict asset limitations and a\n1000 word limit.\n\n\n\n\n\n\n\n\t\t===== Press SPACE to begin =====",
        { text_box_padding, text_box_padding },
        cast(f32)font16.baseSize,
        0,
        rl.WHITE)

      rl.DrawTexture(bg_txr, WINDOW_WIDTH_HALF, 0, rl.WHITE)

      draw_title(font30)

      if true == rl.IsKeyPressed(.SPACE) ||
         true == rl.IsMouseButtonPressed(.LEFT)
      {
        screen_state = .INTRO
      }

    rl.EndDrawing()

  case .INTRO:

    @(static) intro_index: u8 = 1
    @(static) fg_opacity: u16 = 0 // Used in the fade-in "animation"

    if (true == rl.IsKeyPressed(.SPACE) ||
        true == rl.IsMouseButtonPressed(.LEFT)) &&
       fg_opacity <= 0
    {
      intro_index += 1
      intro_len := cast(u8)len(intro_lines)
      // This will trigger the fade-in "animation"
      if intro_index > intro_len
      {
        fg_opacity = 1
        intro_index = intro_len
      }
    }

    rl.BeginDrawing()

      rl.ClearBackground(rl.BLACK)

      y: f32 = 0
      y_increment: f32 = 0
      for i in 0..<intro_index
      {
        y_increment = draw_text_box(
                        font16,
                        intro_lines[i],
                        rl.WHITE,
                        { 0, y + text_box_padding },
                        WINDOW_WIDTH_HALF,
                        text_box_padding,
                        text_padding,
                        font16_max_col_width,
                        rl.WHITE)
        y += y_increment + text_box_padding
      }
      draw_text_box(
        font16,
        "Press SPACE to continue.",
        rl.WHITE,
        { 0, y + text_box_padding },
        WINDOW_WIDTH_HALF,
        text_box_padding,
        text_padding,
        font16_max_col_width,
        rl.YELLOW)

      rl.DrawTexture(bg_txr, WINDOW_WIDTH_HALF, 0, rl.WHITE)
      draw_title(font30)

      if 0 < fg_opacity 
      {
        rl.DrawTexture(
          fg_txr, 
          WINDOW_WIDTH_HALF, 
          0, 
          { 255, 255, 255, cast(u8)fg_opacity })

        rl.DrawTexture(
          face_txrs[.NEUTRAL],
          WINDOW_WIDTH_HALF,
          0,
          { 255, 255, 255, cast(u8)fg_opacity })

        fg_opacity += 8

        if 255 < fg_opacity
        {
          screen_state = .GAME
        }
      }

    rl.EndDrawing()

  case .GAME:

    line := lines[line_index]  // Current line
    lineopt: LineOpt           // Current LineOpt pair

    // Check if the current line has multiple options for the player to choose
    is_multi_option: b8 = false
    for i in line.options
    {
      if 0 <= i
      {
        is_multi_option = true
        break
      }
    }
    
    // Input ===================================================================

    // Check for input
    key_pressed := rl.GetKeyPressed()
    for &oh, i in options_hover
    {
      oh = is_vector2_within_rectangle(
        rl.GetMousePosition(),
        { (option_indent + option_indent), (options_y[i] + text_box_padding),
          (WINDOW_WIDTH_HALF - (text_box_padding * 2) - option_indent), options_h[i] })
    }
    is_mouse_pressed := rl.IsMouseButtonPressed(.LEFT)

    if key_pressed != .KEY_NULL || true == is_mouse_pressed
    {
      // Stop the typing animation
      if true == is_typing
      {
        is_typing = false
      }
      else
      {
        // The current LineOpt pair contains the current line's index
        lineopt.line = line_index

        // Update index and set LineOpt pair's option index accordingly; also,
        // check whether the given input results in a line refresh (new line)
        new_line: b8 = false
        if true == is_multi_option
        {
          is_selected: [2]b8 = {
            (.ONE == key_pressed || .KP_1 == key_pressed ||
                true == options_hover[0]),
            (.TWO == key_pressed || .KP_2 == key_pressed ||
                true == options_hover[1])
          }
          is_available: [2]b8 = {
            (line.options[0] >= 0 && options[line.options[0]].key in key_set),
            (line.options[1] >= 0 && options[line.options[1]].key in key_set)
          }

          if is_selected[0] && is_available[0]
          {
            line_index = options[line.options[0]].next
            lineopt.option = line.options[0]
            new_line = true

          }
          else if is_selected[1] && is_available[1] 
          {

            line_index = options[line.options[1]].next
            lineopt.option = line.options[1]
            new_line = true
          }
        }
        else
        {
          // If the next line is beyond the 'lines' array indexing, end the loop
          if line.next < 0 || cast(i8)len(lines) <= line.next
          {
            run = false
            break
          }
          line_index = line.next
          lineopt.option = 49
          new_line = true
        }
        // This triggers every thime there is a new line (i.e. a selection)
        if true == new_line
        {

          // Insert the current LineOpt pair at the beginning of the buffer
          for i := len(lineopt_buffer) - 1; 0 <= i; i -= 1
          {
            if len(lineopt_buffer) - 1 == i
            {
              continue
            }
            lineopt_buffer[i + 1] = lineopt_buffer[i]
          }
          lineopt_buffer[0] = lineopt

          // Reset the typing animation
          is_typing = true
          typed_characters = 1

          // Add key of current line to set, and ANY if set has more than NONE
          key_set += { lines[line_index].key } 
          key_set += { .ANY } if key_set > { .NONE } else key_set

        }
      }
    }

    // Graphics ================================================================

    vfps_counter = (vfps_counter + 1) % vfps_freq

    rl.BeginDrawing()

      rl.ClearBackground(rl.BLACK)

      // The string drawn will depend on the state of the typing animation
      text: cstring
      if true == is_typing
      {
        text = rl.TextSubtext(line.text, 0, cast(i32)typed_characters)
        is_typing = false if typed_characters == len(line.text) else is_typing
        if 0 == vfps_counter
        {
          typed_characters += 1
        }
      }
      else
      {
        text = line.text
      }

      // Text boxes ============================================================

      // Line ==================================================================

      // - y_increase is set to the height of the drawn box;
      //    this helps render the boxes below it
      y_increase: f32 = draw_text_box(
                      font16, 
                      text, 
                      rl.WHITE,
                      { 0, 0 }, 
                      WINDOW_WIDTH_HALF, 
                      text_box_padding, 
                      text_padding, 
                      font16_max_col_width, 
                      key_colors[line.key]) // Use the color corresponding to
                                            // the current line's key

      // Options ===============================================================

      // When typing animation is over, draw the OPTIONS
      if false == is_typing
      {
        // If the current line just leads into another line, draw the default
        // STR_CONTINUE string and be done with it
        if false == is_multi_option
        {
          rl.DrawTextEx(
            font16,
            "1.",
            { 0, y_increase + text_box_padding * 2 },
            cast(f32)font16.baseSize,
            0,
            rl.YELLOW)
          draw_text_box(
            font16,
            STR_CONTINUE,
            rl.WHITE,
            { option_indent, y_increase + text_box_padding },
            WINDOW_WIDTH_HALF - option_indent,
            text_box_padding,
            text_padding,
            font16_max_col_width,
            rl.WHITE)
        }
        else // If the current line has options for the user to choose, draw each
        {
          y := text_box_padding + y_increase
          for o, i in line.options
          {
            if 0 <= o
            {
              rl.DrawTextEx(
                font16,
                rl.TextFormat("%d.", i + 1),
                { 0, y + text_box_padding },
                cast(f32)font16.baseSize,
                0,
                rl.YELLOW)

              // If the player doesn't have the needed key, draw STR_UNKNOWN
              // instead
              text = options[o].text if options[o].key in key_set else STR_UNKNOWN
              rect_color := key_colors[options[o].key] - { 0, 0, 0, 64 } if false == options_hover[i] else key_colors[options[o].key]
              y_increase = draw_text_box(
                            font16,
                            text,
                            rl.WHITE,
                            { option_indent, y },
                            WINDOW_WIDTH_HALF - option_indent,
                            text_box_padding,
                            text_padding,
                            font16_max_col_width,
                            rect_color)

              y += y_increase + text_box_padding
            }
          }
        }
      }

      // Log ===================================================================

      y := cast(f32)(((font16.baseSize + text_padding) * 2) * 3) + 
              (text_box_padding * 5)
      for lo in lineopt_buffer
      {
        if lo.option < 0 || lo.line < 0
        {
          continue
        }
        y_increase = draw_text_box(
          font16,
          options[lo.option].text,
          rl.GRAY,
          { option_indent, y },
          WINDOW_WIDTH_HALF - option_indent,
          text_box_padding,
          text_padding,
          font16_max_col_width,
          key_colors[options[lo.option].key] - { 0, 0, 0, 127 }) // Fade color
        y += y_increase + text_box_padding

        y_increase = draw_text_box(
          font16,
          lines[lo.line].text,
          rl.GRAY,
          { 0, y },
          WINDOW_WIDTH_HALF,
          text_box_padding,
          text_padding,
          font16_max_col_width,
          key_colors[lines[lo.line].key] - { 0, 0, 0, 127 }) // Fade color
        y += y_increase + text_box_padding
      }

      // Images ================================================================

      rl.DrawTexture(bg_txr, WINDOW_WIDTH_HALF, 0, key_colors[line.key])
      rl.DrawTexture(fg_txr, WINDOW_WIDTH_HALF, 0, key_colors[line.key])
      rl.DrawTexture(
        face_txrs[line.face], 
        WINDOW_WIDTH_HALF, 
        0,
        key_colors[line.key])

      draw_title(font30)

    rl.EndDrawing()
    
  }

	// Anything allocated using temp allocator is invalid after this.
	free_all(context.temp_allocator)
}

// In a web build, this is called when browser changes size. Remove the
// `rl.SetWindowSize` call if you don't want a resizable game.
parent_window_size_changed :: proc(w, h: int) {
	rl.SetWindowSize(c.int(w), c.int(h))
}

shutdown :: proc() {

  rl.UnloadFont(font16)
  rl.UnloadFont(font30)

  rl.UnloadTexture(bg_txr)
  rl.UnloadTexture(fg_txr)
  for txr in face_txrs
  {
    rl.UnloadTexture(txr)
  }
	rl.CloseWindow()
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		// Never run this proc in browser. It contains a 16 ms sleep on web!
		if rl.WindowShouldClose() {
			run = false
		}
	}

	return run
}
