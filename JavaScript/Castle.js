    let front_y_begin = 5;
    let front_y_end = 10;
    let back_y_end = 40;

    let left_x_outside = 20;
    let right_x_outside = 80;
    let left_x_inside = 35;
    let right_x_inside = 65;


function build_floor(height: number, material: any, hole: boolean){
    // PODLOGA MALA
    for (let i = front_y_begin; i < front_y_end; i++) {
        blocks.fill(material, pos(i, height, left_x_inside), pos(i, height, right_x_inside))
    }
    // PODLOGA DUZA
    for (let i=front_y_end; i <= back_y_end; i++) {

        if (hole == true && i > 10 && i < 30){
            blocks.fill(material, pos(i, height, left_x_outside), pos(i, height, left_x_outside + 29))
            blocks.fill(material, pos(i, height, left_x_outside + 35), pos(i, height, right_x_outside))
        }
        else{
            blocks.fill(material, pos(i, height, left_x_outside), pos(i, height, right_x_outside))
        }

    }
}

function build_right_front_wall(start_level: number, height: number, material: any){
    for (let i=start_level; i < height + start_level; i++) {
        blocks.fill(material, pos(front_y_begin, i, left_x_inside), pos(front_y_end, i, left_x_inside))
    }
}

function build_left_front_wall(start_level: number, height: number, material: any){
    for (let i=start_level; i < height + start_level; i++) {
        blocks.fill(material, pos(front_y_begin, i, right_x_inside), pos(front_y_end, i, right_x_inside))
    }
}

function build_right_back_wall(start_level: number, height: number, material: any){
    for (let i=start_level; i < height + start_level; i++) {
        blocks.fill(material, pos(front_y_end, i, left_x_outside), pos(back_y_end, i, left_x_outside))
    }
}

function build_left_back_wall(start_level: number, height: number, material: any){
    for (let i=start_level; i < height + start_level; i++) {
        blocks.fill(material, pos(front_y_end, i, right_x_outside), pos(back_y_end, i, right_x_outside))
    }
}

function build_front_center_wall(start_level: number, height: number, material: any, window: boolean, gate: boolean){
    for (let i=start_level; i < height + start_level; i++) {
        if (window == true){
            blocks.fill(material, pos(front_y_begin, i, left_x_inside), pos(front_y_begin, i, left_x_inside + 7))
            blocks.fill(material, pos(front_y_begin, i, left_x_inside + 11), pos(front_y_begin, i, left_x_inside + 18))
            blocks.fill(material, pos(front_y_begin, i, left_x_inside + 22), pos(front_y_begin, i, right_x_inside))
        }
        else if (gate == true){
            blocks.fill(material, pos(front_y_begin, i, left_x_inside), pos(front_y_begin, i, left_x_inside + 10))
            blocks.fill(material, pos(front_y_begin, i, left_x_inside + 20), pos(front_y_begin, i, right_x_inside))
        }
        else{
            blocks.fill(material, pos(front_y_begin, i, left_x_inside), pos(front_y_begin, i, right_x_inside))
        }
    }
}

function build_front_right_wall(start_level: number, height: number, material: any, window: boolean){
    for (let i=start_level; i < height + start_level; i++) {
        if (window == true){
            blocks.fill(material, pos(front_y_end, i, left_x_outside), pos(front_y_end, i, left_x_outside + 5))
            blocks.fill(material, pos(front_y_end, i, left_x_outside + 10), pos(front_y_end, i, left_x_inside))
        }
        else{
            blocks.fill(material, pos(front_y_end, i, left_x_outside), pos(front_y_end, i, left_x_inside))
        }
    }
}

function build_front_left_wall(start_level: number, height: number, material: any, window: boolean){
    for (let i=start_level; i < height + start_level; i++) {
        if (window == true){
            blocks.fill(material, pos(front_y_end, i, right_x_inside), pos(front_y_end, i, right_x_inside + 5))
            blocks.fill(material, pos(front_y_end, i, right_x_inside + 10), pos(front_y_end, i, right_x_outside))
        }
        else{
            blocks.fill(material, pos(front_y_end, i, right_x_inside), pos(front_y_end, i, right_x_outside))
        }
    }
}

function build_back_wall(start_level: number, height: number, material: any){
    for (let i=start_level; i < height + start_level; i++) {
        blocks.fill(material, pos(back_y_end, i, left_x_outside), pos(back_y_end, i, right_x_outside))
    }
}


function build_gate(size: number, material: any){
    for (let i=0; i < size; i++) {
        blocks.fill(material, pos(front_y_begin - i, 0, 45), pos(front_y_begin - i, 8, 45))
        blocks.fill(material, pos(front_y_begin - i, 0, 55), pos(front_y_begin - i, 8, 55))
        blocks.fill(material, pos(front_y_begin - i, 8, 45), pos(front_y_begin - i, 8, 55))
    }
}

function build_fosa(height: number, material: any){

    //murek
       // for (let i=0; i < height; i++) {
   //     blocks.fill(material, pos(-5, i, 10), pos(45, i, 10))
   //     blocks.fill(material, pos(-5, i, 10), pos(-5, i, 90))
   //     blocks.fill(material, pos(-5, i, 90), pos(45, i, 90))
   //     blocks.fill(material, pos(45, i, 10), pos(45, i, 90))
   // }

    // kopanie dziur

    for (let i=0; i > -4; i--) {
        for (let j=11; j < 16; j++) {
            blocks.fill(AIR, pos(-4, i, j), pos(46, i, j))
        }

        // przod
        for (let j=-4; j < 1; j++) {
            blocks.fill(AIR, pos(j, i, 11), pos(j, i, 89))
        }

        for (let j=89; j > 85; j--) {
            blocks.fill(AIR, pos(-4, i, j), pos(46, i, j))
        }

        for (let j=46; j > 42; j--) {
            blocks.fill(AIR, pos(j, i, 11), pos(j, i, 89))
        }
    }

    // woda
    for (let i=0; i < 75; i++){
        blocks.place(WATER, pos(-2, -2, 11+i))
    }

    for (let i=0; i < 75; i++){
        blocks.place(WATER, pos(43, -2, 11+i))
    }

    // prawa strona woda
    for (let i=0; i < 40; i++){
        blocks.place(WATER, pos(-2+i, -2, 87))
    }

    for (let i=0; i < 40; i++){
        blocks.place(WATER, pos(-2+i, -2, 15))
    }
}

function build_bridge(material: any){

    for (let i=46; i < 55; i++){
        blocks.fill(material, pos(-5, 0, i), pos(5, 0, i))
    }
}

function build_stairs(level: number, height: number, material: any){

    let lenght = 0

    for (let i = 0; i< height + 1; i++){

        lenght = height - i

        for (let j=0; j < 5; j++){
            blocks.fill(material, pos(29, level + i, 50 + j), pos(29-lenght, level + i, 50 + j))
        }
    }

}

function build_tower(position_x: number, position_y: number, level: number, height: number, material: any){
    for (let i=0; i< height + 1; i++){
        //przod
        blocks.fill(material, pos(position_y, level + i, position_x), pos(position_y, level + i, position_x + 5))
        // tył
        blocks.fill(material, pos(position_y+ 5, level + i, position_x), pos(position_y + 5, level + i, position_x + 5))

        //lewo
        blocks.fill(material, pos(position_y, level + i, position_x), pos(position_y + 5, level + i, position_x))

        // prawo
        blocks.fill(material, pos(position_y, level + i, position_x+5), pos(position_y + 5, level + i, position_x+5))

    }
}


player.onChat("x", function on_on_chat() {
    //  pos x, z, y

    let wall_material=STONE
    let floor_material=POLISHED_GRANITE

    build_floor(0, MOSSY_STONE_BRICKS, false)

    build_right_front_wall(1, 23, wall_material)
    build_left_front_wall(1, 23, wall_material)
    build_left_back_wall(1, 23, wall_material)
    build_right_back_wall(1, 23, wall_material)

    // sciana przednia z oknami
    build_front_center_wall(1, 3, wall_material, false, true)
    build_front_center_wall(4, 4, wall_material, false, true)
    build_front_center_wall(8, 4, wall_material, false, false)
    build_front_center_wall(12, 5, wall_material, true, false)
    build_front_center_wall(17, 7, wall_material, false, false)
    build_gate(5, DIAMOND_BLOCK)



    //sciana przednia prawa z oknami
    build_front_right_wall(1, 3, wall_material, false)
    build_front_right_wall(4, 4, wall_material, true)
    build_front_right_wall(8, 16, wall_material, false)

    // sciana przednia lewa z oknami
    build_front_left_wall(1, 3, wall_material, false)
    build_front_left_wall(4, 4, wall_material, true)
    build_front_left_wall(8, 16, wall_material, false)

    // sciana tylna
    build_back_wall(1, 23, wall_material)

    // sufit
    build_floor(10, floor_material, true)
    build_floor(20, BLOCK_OF_QUARTZ, true)

    build_tower(75, 10, 21, 10, POLISHED_ANDESITE)
    build_tower(20, 10, 21, 10, POLISHED_ANDESITE)

    build_stairs(1, 19, GOLD_BLOCK)


    // fosa i most
    build_fosa(2, POLISHED_GRANITE)
    build_bridge(DARK_OAK_WOOD_SLAB)

})

