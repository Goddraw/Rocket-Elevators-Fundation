

// console.log("its connected .............................................");
// function get_buildings() {
//     console.log("jexiste////////////////////////////////////////////////////////////")
//     var id_value_string = $(this).val();
//     if (id_value_string == "") {
//         $("select#intervention_building_id option").remove();
//         var row = "<option value=\"" + "" + "\">" + "Building" + "</option>";
//         $(row).appendTo("#intervention_building_id");
//     } else {
//         //Send the request and update building dropdown
//         $.ajax({
//             dataType: "json",
//             cache: false,
//             url: '/get_buildings/' + id_value_string,
//             timeout: 5000,
//             error: function (XMLHttpRequest, errorTextStatus, error) {
//                 alert("Failed to submit : " + errorTextStatus + " ;" + error);
//             },
//             success: function (data) {
//                 console.log("Im here")
//                 console.log(data)
//                 $("select#intervention_building_id option").remove();
//                 //put in a empty default line
//                 var row = "<option value=\"" + "" + "\">" + "Building" + "</option>";
//                 $(row).appendTo("#intervention_building_id");
//                 // Fill building select
//                 $.each(data, function (i, j) {
//                     row = "<option value=\"" + j.id + "\">" + j.id + "</option>";
//                     $(row).appendTo("#intervention_building_id");
//                 });
//             }
//         });
//     }
// }

