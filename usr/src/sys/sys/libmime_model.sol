pragma ton-solidity >= 0.60.0;
library libmime_model {
    uint8 constant MODEL_3mf   	         = 1; // [http://www.3mf.io/specification][_3MF][Michael_Sweet]
    uint8 constant MODEL_e57             = 2; // [ASTM]
    uint8 constant MODEL_example         = 3; // [RFC4735]
    uint8 constant MODEL_gltf_binary     = 4; // [Khronos][Saurabh_Bhatia]
    uint8 constant MODEL_gltf_json       = 5; // [Khronos][Uli_Klumpp]
    uint8 constant MODEL_iges            = 6; // [Curtis_Parks]
    uint8 constant MODEL_mesh            = 7; // [RFC2077]
    uint8 constant MODEL_mtl             = 8; // [DICOM_Standards_Committee][Luiza_Kowalczyk]
    uint8 constant MODEL_obj             = 9; // [DICOM_Standards_Committee][Luiza_Kowalczyk]
    uint8 constant MODEL_prc             = 10; // [ISO-TC_171-SC_2][Betsy_Fanning]
    uint8 constant MODEL_step            = 11; // [ISO-TC_184-SC_4][Dana_Tripp]
    uint8 constant MODEL_step_xml        = 12; // [ISO-TC_184-SC_4][Dana_Tripp]
    uint8 constant MODEL_step_zip        = 13; // [ISO-TC_184-SC_4][Dana_Tripp]
    uint8 constant MODEL_step_xml_zip    = 14; // [ISO-TC_184-SC_4][Dana_Tripp]
    uint8 constant MODEL_stl             = 15; // [DICOM_Standards_Committee][Lisa_Spellman]
    uint8 constant MODEL_u3d             = 16; // [PDF_Association][Peter_Wyatt]
    uint8 constant MODEL_vnd_collada_xml = 17; // [James_Riordon]
    uint8 constant MODEL_vnd_dwf         = 18; // [Jason_Pratt]
    uint8 constant MODEL_vnd_flatland_3dml = 19; // [Michael_Powers]
    uint8 constant MODEL_vnd_gdl         = 20; // [Attila_Babits]
    uint8 constant MODEL_vnd_gs_gdl      = 21; // [Attila_Babits]
    uint8 constant MODEL_vnd_gtw         = 22; // [Yutaka_Ozaki]
    uint8 constant MODEL_vnd_moml_xml    = 23; // [Christopher_Brooks]
    uint8 constant MODEL_vnd_mts         = 24; // [Boris_Rabinovitch]
    uint8 constant MODEL_vnd_opengex     = 25; // [Eric_Lengyel]
    uint8 constant MODEL_vnd_parasolid_transmit_binary = 26; // [Parasolid]
    uint8 constant MODEL_vnd_parasolid_transmit_text = 27; // [Parasolid]
    uint8 constant MODEL_vnd_pytha_pyox  = 28; // [Daniel_Flassig]
    uint8 constant MODEL_vnd_rosette_annotated_data_model = 29; // [Benson_Margulies]
    uint8 constant MODEL_vnd_sap_vds     = 30; // [SAP_SE][Igor_Afanasyev]
    uint8 constant MODEL_vnd_usdz_zip    = 31; // [Sebastian_Grassia]
    uint8 constant MODEL_vnd_valve_source_compiled_map = 32; // [Henrik_Andersson]
    uint8 constant MODEL_vnd_vtu         = 33; // [Boris_Rabinovitch]
    uint8 constant MODEL_vrml 	         = 34; // [RFC2077]
    uint8 constant MODEL_x3d_vrml        = 35; // [Web3D][Web3D_X3D]
    uint8 constant MODEL_x3d_fastinfoset = 36; // [Web3D_X3D]
    uint8 constant MODEL_x3d_xml         = 37; // [Web3D][Web3D_X3D]
}