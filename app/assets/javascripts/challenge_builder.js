function update_chosen_image(ui) {
    clicked_img_id = $(ui).attr('id').replace('image-', '');

    img_1 = $('#image-one');
    img_2 = $('#image-two');

    img_1_input = $('#challenge_image_1_id');
    img_2_input = $('#challenge_image_2_id');

    if (img_1_input.val() == "") {
        img_1.html($(ui).html());
        img_1_input.val(clicked_img_id);
    } else {
        img_2.html($(ui).html());
        img_2_input.val(clicked_img_id);
    }

}
