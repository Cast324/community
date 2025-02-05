"""
Applet: Tetris Clock
Summary: Falling block clock
Description: Shows the current time by animating falling blocks. Highly customizable.
Author: MarkGamed7794
"""

load("encoding/json.star", "json")
load("random.star", "random")
load("render.star", "render")
load("schema.star", "schema")
load("time.star", "time")

FRAME_RATE = 14  # in FPS
FRAME_COUNT = FRAME_RATE * 15
SPACER_WIDTH = 1
COLON_WIDTH = 1
GRID_WIDTH = 6
GRID_HEIGHT = 12
FINAL_GRID_WIDTH = 32
MOVEMENT_ODDS = 2  # 1 in X+1
DIGIT_LENGTH = 60  # frames to make piece, approximately
INITIAL_DELAY = 12
BACKGROUND_COLOUR = "#222"
EMPTY_CELL = [False, BACKGROUND_COLOUR, 0]
DIGIT_OFFSETS = [1, 8, 18, 25]
COLON_OFFSET = 15
DIGIT_SHAPES = {
    0: "ZERO",
    1: "ONE",
    2: "TWO",
    3: "THREE",
    4: "FOUR",
    5: "FIVE",
    6: "SIX",
    7: "SEVEN",
    8: "EIGHT",
    9: "NINE",
}
MONTHS = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC",
]
DEFAULT_TIMEZONE = "America/New_York"
DEFAULT_LOCATION = """
{
    "lat": "40.6781784",
    "lng": "-73.9441579",
    "description": "Brooklyn, NY, USA",
    "locality": "Brooklyn",
    "place_id": "ChIJCSF8lBZEwokRhngABHRcdoI",
    "timezone": "America/New_York"
}
"""

# Piece definitions. Y+ goes down, X+ goes right.
# Spawn orientations:
#  [][]        []  [][]    [][]            []        []
#    [][]  [][][]  [][]  [][]    [][][][]  [][][]  [][][]
#
PIECES = {
    "T0": [[0, -1], [-1, 0], [0, 0], [1, 0]],
    "TR": [[0, -1], [0, 0], [1, 0], [0, 1]],
    "T2": [[-1, 0], [0, 0], [1, 0], [0, 1]],
    "TL": [[0, -1], [-1, 0], [0, 0], [0, 1]],
    "I0": [[-1, 0], [0, 0], [1, 0], [2, 0]],
    "IR": [[1, -1], [1, 0], [1, 1], [1, 2]],
    "I2": [[-1, 1], [0, 1], [1, 1], [2, 1]],
    "IL": [[0, -1], [0, 0], [0, 1], [0, 2]],
    "O0": [[0, -1], [1, -1], [0, 0], [1, 0]],
    "OR": [[0, -1], [1, -1], [0, 0], [1, 0]],
    "O2": [[0, -1], [1, -1], [0, 0], [1, 0]],
    "OL": [[0, -1], [1, -1], [0, 0], [1, 0]],
    "L0": [[1, -1], [-1, 0], [0, 0], [1, 0]],
    "LR": [[0, -1], [0, 0], [0, 1], [1, 1]],
    "L2": [[-1, 0], [0, 0], [1, 0], [-1, 1]],
    "LL": [[-1, -1], [0, -1], [0, 0], [0, 1]],
    "J0": [[-1, -1], [-1, 0], [0, 0], [1, 0]],
    "JR": [[0, -1], [1, -1], [0, 0], [0, 1]],
    "J2": [[-1, 0], [0, 0], [1, 0], [1, 1]],
    "JL": [[0, -1], [0, 0], [-1, 1], [0, 1]],
    "S0": [[0, -1], [1, -1], [-1, 0], [0, 0]],
    "SR": [[0, -1], [0, 0], [1, 0], [1, 1]],
    "S2": [[0, 0], [1, 0], [-1, -1], [0, -1]],
    "SL": [[-1, -1], [-1, 0], [0, 0], [0, 1]],
    "Z0": [[-1, -1], [0, -1], [0, 0], [1, 0]],
    "ZR": [[1, -1], [0, 0], [1, 0], [0, 1]],
    "Z2": [[-1, 0], [0, 0], [0, -1], [1, -1]],
    "ZL": [[0, -1], [-1, 0], [0, 0], [-1, 1]],
}

PIECE_COLOURS = {
    "T0": 0,
    "TR": 0,
    "T2": 0,
    "TL": 0,
    "I0": 1,
    "IR": 1,
    "I2": 1,
    "IL": 1,
    "O0": 2,
    "OR": 2,
    "O2": 2,
    "OL": 2,
    "L0": 3,
    "LR": 3,
    "L2": 3,
    "LL": 3,
    "J0": 4,
    "JR": 4,
    "J2": 4,
    "JL": 4,
    "S0": 5,
    "SR": 5,
    "S2": 5,
    "SL": 5,
    "Z0": 6,
    "ZR": 6,
    "Z2": 6,
    "ZL": 6,
}

COLOUR_SCHEMES = {
    # [T, I, O, L, J, S, Z, background, bar]
    "standard_dark": [[187, 68, 255], [68, 255, 255], [255, 255, 68], [255, 187, 68], [68, 136, 255], [68, 255, 68], [255, 68, 68], [34, 34, 34], [255, 255, 255]],
    "standard_light": [[187, 68, 255], [68, 255, 255], [255, 255, 68], [255, 187, 68], [68, 136, 255], [68, 255, 68], [255, 68, 68], [200, 200, 200], [68, 68, 68]],
    "autumn": [[241, 235, 163], [240, 227, 152], [237, 211, 130], [241, 198, 118], [245, 185, 105], [249, 172, 92], [251, 165, 86], [176, 100, 38], [252, 143, 54]],
    "winter": [[214, 221, 255], [192, 201, 245], [173, 185, 237], [163, 173, 227], [156, 164, 219], [147, 152, 209], [139, 142, 201], [89, 104, 150], [54, 65, 89]],
    "spring": [[161, 213, 151], [153, 196, 143], [150, 190, 140], [137, 180, 129], [124, 169, 118], [111, 159, 107], [98, 148, 98], [201, 242, 199], [69, 99, 61]],
    "summer": [[255, 218, 185], [254, 213, 182], [253, 207, 178], [251, 196, 171], [250, 185, 164], [249, 179, 161], [248, 173, 157], [236, 91, 91], [165, 63, 63]],
    "monochrome_dark": [[255, 255, 255], [255, 255, 255], [255, 255, 255], [255, 255, 255], [255, 255, 255], [255, 255, 255], [255, 255, 255], [0, 0, 0], [255, 255, 255]],
    "monochrome_light": [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [255, 255, 255], [0, 0, 0]],
}

ROTATE_CW = {
    "T0": "TR",
    "TR": "T2",
    "T2": "TL",
    "TL": "T0",
    "I0": "IR",
    "IR": "I2",
    "I2": "IL",
    "IL": "I0",
    "O0": "OR",
    "OR": "O2",
    "O2": "OL",
    "OL": "O0",
    "L0": "LR",
    "LR": "L2",
    "L2": "LL",
    "LL": "L0",
    "J0": "JR",
    "JR": "J2",
    "J2": "JL",
    "JL": "J0",
    "S0": "SR",
    "SR": "S2",
    "S2": "SL",
    "SL": "S0",
    "Z0": "ZR",
    "ZR": "Z2",
    "Z2": "ZL",
    "ZL": "Z0",
}

# Piece placement definitions are [shape, x position]. Pieces are represented by their letter followed by their orientation. X positions are based off of the piece definition.
SUBSHAPES = {
    "TWO_BY_FOUR": [
        [["O0", 0], ["O0", 0]],
        [["LR", 0], ["LL", 1]],
        [["JL", 1], ["JR", 0]],
        [["IL", 0], ["IR", 0]],
    ],
    "TWO_BY_SIX": [
        [["TWO_BY_FOUR", 0], ["O0", 0]],
        [["O0", 0], ["TWO_BY_FOUR", 0]],
        [["JL", 1], ["IL", 0], ["LL", 1]],
        [["LR", 0], ["IL", 1], ["JR", 0]],
    ],
    "TWO_BY_EIGHT": [
        [["TWO_BY_SIX", 0], ["O0", 0]],
        [["O0", 0], ["TWO_BY_SIX", 0]],
        [["TWO_BY_FOUR", 0], ["TWO_BY_FOUR", 0]],
    ],
    "FOUR_BY_TWO": [
        [["O0", -1], ["O0", 1]],
        [["L0", 1], ["L2", 0]],
        [["J0", 0], ["J2", 1]],
    ],
    "SIX_BY_TWO": [
        [["O0", -2], ["FOUR_BY_TWO", 1]],
        [["O0", 2], ["FOUR_BY_TWO", -1]],
        [["L0", 2], ["J0", -1], ["I0", 0]],
        [["I0", 0], ["L2", -1], ["J2", 2]],
    ],
    "SQUARE_HOOK_DOWN": [
        [["JL", 2], ["J2", 0]],
        [["O0", 1], ["I0", 0]],
    ],
    "SQUARE_HOOK_UP": [
        [["L0", 0], ["LL", 2]],
        [["I0", 0], ["O0", 1]],
    ],
    "HORIZONTAL_SLANT": [
        [["Z0", -1], ["Z0", 1]],
        [["I0", 0], ["I0", -1]],
        [["T0", 1], ["T2", -1]],
    ],
    "VERTICAL_SLANT_RIGHT": [
        [["ZR", 0], ["ZR", 0]],
        [["TR", 0], ["TL", 1]],
        [["IR", 0], ["IL", 0]],
    ],
    "VERTICAL_SLANT_LEFT": [
        [["SR", 0], ["SR", 0]],
        [["TL", 1], ["TR", 0]],
        [["IR", 0], ["IL", 0]],
    ],
    "BOWL": [
        [["O0", 0], ["SL", -1], ["ZR", 2]],
        [["SL", -1], ["ZR", 2], ["O0", 0]],
        [["ZR", 2], ["O0", 0], ["SL", -1]],
        [["O0", 0], ["ZR", 2], ["SL", -1]],
        [["SL", -1], ["O0", 0], ["ZR", 2]],
        [["ZR", 2], ["SL", -1], ["O0", 0]],
    ],
    "SIX_MIDDLE": [
        [["T2", -1], ["T2", 2], ["I0", 0], ["TR", -2]],
        [["T2", 2], ["L2", 1], ["VERTICAL_SLANT_LEFT", -2]],
    ],
    "ONE": [
        ["TWO_BY_EIGHT", 0],
    ],
    "TWO": [
        ["SIX_BY_TWO", 0],
        ["O0", -2],
        ["Z0", 0],
        ["T2", 2],
        ["O0", 2],
        ["S0", 1],
        ["S0", -1],
    ],
    "THREE": [
        ["HORIZONTAL_SLANT", 0],
        ["SQUARE_HOOK_DOWN", 1],
        ["SQUARE_HOOK_UP", 1],
        ["S0", 1],
        ["S0", -1],
    ],
    "FOUR": [
        ["O0", 1],
        ["I0", -1],
        ["O0", 2],
        ["L0", 0],
        ["VERTICAL_SLANT_RIGHT", -2],
        ["TL", 2],
        #["O0", 1], ["I0", -1], ["O0", 2], ["J0", -1], ["VERTICAL_SLANT_RIGHT", 1], ["TL", -1]
    ],
    "FIVE": [
        ["HORIZONTAL_SLANT", 0],
        ["O0", 2],
        ["T0", 2],
        ["S0", 0],
        ["O0", -2],
        ["I0", 0],
        ["L2", -1],
        ["J2", 2],
    ],
    "SIX": [
        ["BOWL", 0],
        ["SIX_MIDDLE", 0],
        ["I0", 0],
        ["I0", 0],
    ],
    "SEVEN": [
        ["LR", 0],
        ["JR", 1],
        ["S0", 2],
        ["I0", 0],
        ["L2", -1],
        ["J2", 2],
    ],
    "EIGHT": [
        ["BOWL", 0],
        ["TR", -1],
        ["T2", 2],
        ["IL", -2],
        ["I0", 1],
        ["O0", 2],
        ["S0", 1],
        ["JR", -1],
    ],
    "NINE": [
        ["FOUR_BY_TWO", 0],
        ["TL", 3],
        ["I0", 0],
        ["T0", -1],
        ["T0", 2],
        ["J2", 2],
        ["L2", -1],
        ["I0", 0],
    ],
    "ZERO": [
        ["BOWL", 0],
        ["VERTICAL_SLANT_LEFT", -2],
        ["VERTICAL_SLANT_RIGHT", 2],
        ["FOUR_BY_TWO", 0],
    ],
}

def generateFinalPieces(subshape, offset, temp_grid):
    # get final pieces and positions
    final_pieces = []
    for piece in subshape:
        if (PIECES.get(piece[0])):
            # drop from just above top of grid
            temp_piece = [piece[0], piece[1] + offset, 0]

            # So I can't use while loops for some reason? World's hackiest workaround
            for i in range(GRID_HEIGHT + 4):
                if (not collides(temp_grid, temp_piece)):
                    # Even more dumb workarounds
                    temp_piece[2] += (i * 0) + 1
                else:
                    break
            temp_piece[2] -= 1
            final_pieces.append(temp_piece)
            place(temp_grid, temp_piece)
        else:
            new_subshape = SUBSHAPES[piece[0]]
            final_pieces.extend(generateFinalPieces(new_subshape[random.number(0, len(new_subshape) - 1)], offset + piece[1], temp_grid))
    return final_pieces

def generatePieceSequence(subshape, dropOffset, length, moveOdds):
    final_pieces = generateFinalPieces(SUBSHAPES[subshape], 2, new_grid([]))
    temp_grid = new_grid([])
    piece_sequences = []
    for piece in final_pieces:
        place(temp_grid, piece)
    for idx in range(0, len(final_pieces)):
        i = len(final_pieces) - idx - 1
        piece = final_pieces[i]
        movements = []  # 0 = nothing, -1/1 = move left/right, -2/2 = rotate ccw/cw
        unplace(temp_grid, piece)
        for movementNum in range((i + 1) * (length // len(final_pieces)) + dropOffset + INITIAL_DELAY):
            movementNum = movementNum
            if (random.number(0, moveOdds) <= 1 and moveOdds < 10000):
                # do a movement
                # movements happen just after gravity, but since we're doing it backwards the gravity happens afterwards
                movement = random.number(0, 4)

                # we're "undoing" the movement, so this looks backwards
                if (movement == -1):
                    piece[1] += 1
                if (movement == 1):
                    piece[1] -= 1
                if (movement == -2):
                    piece[0] = ROTATE_CW[piece[0]]
                if (movement == 2):
                    piece[0] = ROTATE_CW[ROTATE_CW[ROTATE_CW[piece[0]]]]

                if (not collides(temp_grid, piece)):
                    movements.insert(0, movement)
                else:
                    if (movement == 1):
                        piece[1] += 1
                    if (movement == -1):
                        piece[1] -= 1
                    if (movement == 2):
                        piece[0] = ROTATE_CW[piece[0]]
                    if (movement == -2):
                        piece[0] = ROTATE_CW[ROTATE_CW[ROTATE_CW[piece[0]]]]
                    movements.insert(0, 0)
            else:
                # don't
                movements.insert(0, 0)
            piece[2] -= 1

        # piece, movements, placed?
        piece_sequences.insert(0, [piece, movements, False, 0])
    return piece_sequences

def unplace(grid, piece):
    for cell in PIECES[piece[0]]:
        cx, cy = cell[0] + piece[1], cell[1] + piece[2]
        if (cx >= 0 and cx < GRID_WIDTH and cy >= 0 and cy < GRID_HEIGHT):
            grid["board"][cy][cx][0] = EMPTY_CELL
        elif (cy >= GRID_HEIGHT):
            return True
    return False

def place(grid, piece):
    for cell in PIECES[piece[0]]:
        cx, cy = cell[0] + piece[1], cell[1] + piece[2]
        if (cx >= 0 and cx < GRID_WIDTH and cy >= 0 and cy < GRID_HEIGHT):
            grid["board"][cy][cx] = [True, "#fff", 1]
        elif (cy >= GRID_HEIGHT):
            return True
    return False

def collides(grid, piece):
    for cell in PIECES[piece[0]]:
        cx, cy = cell[0] + piece[1], cell[1] + piece[2]
        if (cx >= 0 and cx < GRID_WIDTH and cy >= 0 and cy < GRID_HEIGHT):
            if (grid["board"][cy][cx][0]):
                return True
        elif (cy >= GRID_HEIGHT):
            return True
    return False

def new_grid(pieces):
    grid = {
        "board": [],
        "pieces": pieces,
    }
    for y in range(GRID_HEIGHT):
        grid["board"].append([])
        for x in range(GRID_WIDTH):
            # cells are [solid?, colour, age]
            grid["board"][y].append(EMPTY_CELL)
            x = x  # Stop it
    return grid

def lerp(a, b, x):
    return a + (b - a) * x

def fade_colour(colA, colB, x):
    lerpAmt = max(0, min(x, 1))
    mixedCol = (
        int(lerp(colA[0], colB[0], lerpAmt)),
        int(lerp(colA[1], colB[1], lerpAmt)),
        int(lerp(colA[2], colB[2], lerpAmt)),
    )
    return rgb2hex(mixedCol)

def pad(str):
    if (len(str) == 1):
        return "0" + str
    return str

def rgb2hex(col):
    mixedCol = (
        pad("%x" % int(col[0])),
        pad("%x" % int(col[1])),
        pad("%x" % int(col[2])),
    )
    return "#%s%s%s" % mixedCol

def main(config):
    # config
    TWENTY_FOUR_HOUR = config.bool("24hr", False)
    LEADING_ZERO = config.bool("leadzero", True)
    SHOW_DATE = config.bool("showdate", True)
    COLOUR_SCHEME_NAME = config.get("colourscheme", "standard_dark")
    BACKGROUND_COLOUR = rgb2hex(COLOUR_SCHEMES[COLOUR_SCHEME_NAME][7])
    FADE_SPEED = int(config.get("fadespeed", 10))
    FADE_COLOUR = (FADE_SPEED < 1000000)
    FRAME_RATE = int(config.get("framerate", 10))
    DIGIT_LENGTH = int(config.get("digitlength", 60))
    MOVEMENT_ODDS = int(config.get("movementrate", 2))

    location = config.get("location", DEFAULT_LOCATION)
    loc = json.decode(location)
    timezone = loc.get("timezone", config.get("$tz", DEFAULT_TIMEZONE))  # Utilize special timezone variable
    now = time.now().in_location(timezone)

    adjusted_hours = now.hour if TWENTY_FOUR_HOUR else ((now.hour - 1) % 12 + 1)

    #digits = [time_string[0], time_string[1], time_string[3], time_string[4]]
    if ((not LEADING_ZERO) and adjusted_hours < 10):
        DIGIT_OFFSETS = [8, 18, 25]
        sequences = [
            generatePieceSequence(DIGIT_SHAPES[adjusted_hours % 10], (DIGIT_LENGTH * 1 // 10), DIGIT_LENGTH, MOVEMENT_ODDS),
            generatePieceSequence(DIGIT_SHAPES[now.minute // 10], 0, DIGIT_LENGTH, MOVEMENT_ODDS),
            generatePieceSequence(DIGIT_SHAPES[now.minute % 10], (DIGIT_LENGTH * 2 // 10), DIGIT_LENGTH, MOVEMENT_ODDS),
        ]
    else:
        DIGIT_OFFSETS = [1, 8, 18, 25]
        sequences = [
            generatePieceSequence(DIGIT_SHAPES[adjusted_hours // 10], (DIGIT_LENGTH * 3 // 10), DIGIT_LENGTH, MOVEMENT_ODDS),
            generatePieceSequence(DIGIT_SHAPES[adjusted_hours % 10], (DIGIT_LENGTH * 1 // 10), DIGIT_LENGTH, MOVEMENT_ODDS),
            generatePieceSequence(DIGIT_SHAPES[now.minute // 10], 0, DIGIT_LENGTH, MOVEMENT_ODDS),
            generatePieceSequence(DIGIT_SHAPES[now.minute % 10], (DIGIT_LENGTH * 2 // 10), DIGIT_LENGTH, MOVEMENT_ODDS),
        ]
    frames = []

    for FRAME in range(FRAME_COUNT):
        # prepare a temporary grid for rendering
        colourGrid = []
        for y in range(GRID_HEIGHT):
            colourGrid.append([])
            for x in range(FINAL_GRID_WIDTH):
                colourGrid[y].append(BACKGROUND_COLOUR)

        # update sequences

        sequenceNo = 0
        for sequence in sequences:
            # execute the first movement in each piece
            for piece in sequence:
                if (len(piece[1]) == 0):
                    if (not piece[2]):
                        # piece has no more movements :(
                        piece[2] = True
                    piece[3] += 1
                else:
                    movement = piece[1].pop(0)
                    piece[0][2] += 1
                    if (movement == 1):
                        piece[0][1] += 1
                    if (movement == -1):
                        piece[0][1] -= 1
                    if (movement == 2):
                        piece[0][0] = ROTATE_CW[piece[0][0]]
                    if (movement == -2):
                        piece[0][0] = ROTATE_CW[ROTATE_CW[ROTATE_CW[piece[0][0]]]]

                for cell in PIECES[piece[0][0]]:
                    cx, cy = cell[0] + piece[0][1] + DIGIT_OFFSETS[sequenceNo], cell[1] + piece[0][2]
                    if (cx >= 0 and cx < FINAL_GRID_WIDTH and cy >= 0 and cy < GRID_HEIGHT):
                        colourLerpAmt = piece[3] / FADE_SPEED if FADE_COLOUR else 0
                        colourGrid[cy][cx] = fade_colour(
                            COLOUR_SCHEMES[COLOUR_SCHEME_NAME][PIECE_COLOURS[piece[0][0]]],
                            COLOUR_SCHEMES[COLOUR_SCHEME_NAME][8],
                            colourLerpAmt,
                        )
            sequenceNo += 1

        # colon
        if (FRAME % FRAME_RATE < FRAME_RATE / 2):
            col = fade_colour(
                COLOUR_SCHEMES[COLOUR_SCHEME_NAME][PIECE_COLOURS["O0"]],
                COLOUR_SCHEMES[COLOUR_SCHEME_NAME][8],
                1 if FADE_COLOUR else 0,
            )
            colourGrid[GRID_HEIGHT - 2][COLON_OFFSET] = col
            colourGrid[GRID_HEIGHT - 2][COLON_OFFSET + 1] = col
            colourGrid[GRID_HEIGHT - 3][COLON_OFFSET] = col
            colourGrid[GRID_HEIGHT - 3][COLON_OFFSET + 1] = col

            colourGrid[GRID_HEIGHT - 6][COLON_OFFSET] = col
            colourGrid[GRID_HEIGHT - 6][COLON_OFFSET + 1] = col
            colourGrid[GRID_HEIGHT - 7][COLON_OFFSET] = col
            colourGrid[GRID_HEIGHT - 7][COLON_OFFSET + 1] = col

        # render the grid
        rows = []
        for y in range(GRID_HEIGHT):
            colourGrid.append([])
            row = []
            for x in range(FINAL_GRID_WIDTH):
                row.append(render.Box(
                    width = 2,
                    height = 2,
                    color = colourGrid[y][x],
                ))
            rows.append(render.Row(
                children = row,
            ))
        BAR_COLOUR = rgb2hex(COLOUR_SCHEMES[COLOUR_SCHEME_NAME][8])
        rows.extend(
            [render.Box(
                width = 64,
                height = 8,
                color = BAR_COLOUR,
                child = render.Box(
                    width = 63,
                    height = 8,
                    color = BAR_COLOUR,
                    child = render.Row(
                        expanded = True,
                        main_align = "space_between",
                        cross_align = "end",
                        children = [
                            render.Text(
                                "" if TWENTY_FOUR_HOUR else (now.hour < 12 and "AM" or "PM"),
                                color = BACKGROUND_COLOUR,
                            ),
                            render.Text(
                                ("%s %d" % (MONTHS[now.month - 1], now.day)) if SHOW_DATE else "",
                                color = BACKGROUND_COLOUR,
                            ),
                        ],
                    ),
                ),
            )],
        )
        frames.append(render.Column(
            children = rows,
        ))

    return render.Root(
        delay = 1000 // FRAME_RATE,
        child = render.Animation(
            children = frames,
        ),
    )

def get_schema():
    themeOptions = [
        schema.Option(
            display = "Standard Dark",
            value = "standard_dark",
        ),
        schema.Option(
            display = "Standard Light",
            value = "standard_light",
        ),
        schema.Option(
            display = "Spring",
            value = "spring",
        ),
        schema.Option(
            display = "Summer",
            value = "summer",
        ),
        schema.Option(
            display = "Autumn",
            value = "autumn",
        ),
        schema.Option(
            display = "Winter",
            value = "winter",
        ),
        schema.Option(
            display = "Monochrome Dark",
            value = "monochrome_dark",
        ),
        schema.Option(
            display = "Monochrome Light",
            value = "monochrome_light",
        ),
    ]
    fadeSpeedOptions = [
        schema.Option(
            display = "Disabled",
            value = "1000000",
        ),
        schema.Option(
            display = "Very Slow",
            value = "45",
        ),
        schema.Option(
            display = "Slow",
            value = "30",
        ),
        schema.Option(
            display = "Medium",
            value = "20",
        ),
        schema.Option(
            display = "Fast",
            value = "14",
        ),
        schema.Option(
            display = "Very Fast",
            value = "8",
        ),
        schema.Option(
            display = "Instant",
            value = "1",
        ),
    ]
    framerateOptions = [
        schema.Option(
            display = "Slow",
            value = "8",
        ),
        schema.Option(
            display = "Medium",
            value = "10",
        ),
        schema.Option(
            display = "Fast",
            value = "14",
        ),
        schema.Option(
            display = "Very Fast",
            value = "20",
        ),
    ]
    digitLengthOptions = [
        schema.Option(
            display = "Very Slow",
            value = "90",
        ),
        schema.Option(
            display = "Slow",
            value = "75",
        ),
        schema.Option(
            display = "Medium",
            value = "60",
        ),
        schema.Option(
            display = "Fast",
            value = "40",
        ),
        schema.Option(
            display = "Very Fast",
            value = "28",
        ),
    ]
    movementRateOptions = [
        schema.Option(
            display = "None",
            value = "1000000",
        ),
        schema.Option(
            display = "Slow",
            value = "16",
        ),
        schema.Option(
            display = "Medium",
            value = "7",
        ),
        schema.Option(
            display = "Fast",
            value = "2",
        ),
        schema.Option(
            display = "Extreme",
            value = "1",
        ),
    ]
    return schema.Schema(
        version = "1",
        fields = [
            schema.Dropdown(
                id = "colourscheme",
                name = "Colour Scheme",
                desc = "The colour scheme of the app.",
                icon = "brush",
                default = themeOptions[0].value,
                options = themeOptions,
            ),
            schema.Location(
                id = "location",
                name = "Location",
                desc = "The location to display the time from.",
                icon = "locationDot",
            ),
            schema.Toggle(
                id = "24hr",
                name = "24-Hour Clock",
                desc = "Whether or not to show a 24-hour clock (on) or 12-hour clock (off).",
                icon = "clock",
                default = False,
            ),
            schema.Toggle(
                id = "leadzero",
                name = "Leading Zero",
                desc = "Whether or not to show a leading zero for the hours.",
                icon = "creativeCommonsZero",
                default = False,
            ),
            schema.Toggle(
                id = "showdate",
                name = "Show Date",
                desc = "Whether or not to show the date on the lower-right.",
                icon = "calendar",
                default = True,
            ),
            schema.Dropdown(
                id = "fadespeed",
                name = "Fade Speed",
                desc = "The speed at which the blocks fade out.",
                icon = "stopwatch",
                default = fadeSpeedOptions[2].value,
                options = fadeSpeedOptions,
            ),
            schema.Dropdown(
                id = "framerate",
                name = "Animation Speed",
                desc = "The speed at which the animation plays.",
                icon = "gear",
                default = framerateOptions[1].value,
                options = framerateOptions,
            ),
            schema.Dropdown(
                id = "digitlength",
                name = "Build Speed",
                desc = "The speed at which the individual digits are built.",
                icon = "hourglassStart",
                default = digitLengthOptions[2].value,
                options = digitLengthOptions,
            ),
            schema.Dropdown(
                id = "movementrate",
                name = "Movement Rate",
                desc = "How fast and how much the pieces move on their way down.",
                icon = "arrowsUpDownLeftRight",
                default = movementRateOptions[3].value,
                options = movementRateOptions,
            ),
        ],
    )
