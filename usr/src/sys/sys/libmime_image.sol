pragma ton-solidity >= 0.60.0;
library libmime_image {

    uint8 constant IMAGE_aces 	 	   = 1; // [SMPTE][Howard_Lukk]
    uint8 constant IMAGE_avci 	 	   = 2; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_avcs 	 	   = 3; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_avif 	 	   = 4; // [Alliance_for_Open_Media][Cyril_Concolato]
    uint8 constant IMAGE_bmp 	 	   = 5; // [RFC7903]
    uint8 constant IMAGE_cgm 	 	   = 6; // [Alan_Francis]
    uint8 constant IMAGE_dicom_rle 	   = 7; // [DICOM_Standards_Committee][David_Clunie]
    uint8 constant IMAGE_emf 	       = 8; // [RFC7903]
    uint8 constant IMAGE_example 	   = 9; // [RFC4735]
    uint8 constant IMAGE_fits 	 	   = 10; // [RFC4047]
    uint8 constant IMAGE_g3fax 	 	   = 11; // [RFC1494]
    uint8 constant IMAGE_gif 		   = 12; // [RFC2045][RFC2046]
    uint8 constant IMAGE_heic 	 	   = 13; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_heic_sequence = 14; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_heif 	 	   = 15; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_heif_sequence = 16; // [ISO-IEC_JTC1][David_Singer]
    uint8 constant IMAGE_hej2k 	 	   = 17; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_hsj2 	 	   = 18; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_ief 		   = 19; // [RFC1314]
    uint8 constant IMAGE_jls 	 	   = 20; // [DICOM_Standards_Committee][David_Clunie]
    uint8 constant IMAGE_jp2 	 	   = 21; // [RFC3745]
    uint8 constant IMAGE_jpeg 		   = 22; // [RFC2045][RFC2046]
    uint8 constant IMAGE_jph 	 	   = 23; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_jphc 	 	   = 24; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_jpm 	 	   = 25; // [RFC3745]
    uint8 constant IMAGE_jpx 	 	   = 26; // [RFC3745]
    uint8 constant IMAGE_jxr 	 	   = 27; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_jxrA 	 	   = 28; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_jxrS 	 	   = 29; // [ISO-IEC_JTC1][ITU-T]
    uint8 constant IMAGE_jxs 	 	   = 30; // [ISO-IEC_JTC1]
    uint8 constant IMAGE_jxsc 	 	   = 31; // [ISO-IEC_JTC1]
    uint8 constant IMAGE_jxsi 	 	   = 32; // [ISO-IEC_JTC1]
    uint8 constant IMAGE_jxss 	 	   = 33; // [ISO-IEC_JTC1]
    uint8 constant IMAGE_ktx 	 	   = 34; // [Khronos][Mark_Callow]
    uint8 constant IMAGE_ktx2 	 	   = 35; // [Khronos][Mark_Callow]
    uint8 constant IMAGE_naplps 	   = 36; // [Ilya_Ferber]
    uint8 constant IMAGE_png 	 	   = 37; // [W3C][PNG_Working_Group]
    uint8 constant IMAGE_prs_btif 	   = 38; // [Ben_Simon]
    uint8 constant IMAGE_prs_pti 	   = 39; // [Juern_Laun]
    uint8 constant IMAGE_pwg_raster    = 40; // [Michael_Sweet]
    uint8 constant IMAGE_svg_xml 	   = 41; // [W3C][http://www.w3.org/TR/SVG/mimereg.html]
    uint8 constant IMAGE_t38 	 	   = 42; // [RFC3362]
    uint8 constant IMAGE_tiff 	 	   = 43; // [RFC3302]
    uint8 constant IMAGE_tiff_fx 	   = 44; // [RFC3950]
    uint8 constant IMAGE_vnd_adobe_photoshop 	    = 45; // [Kim_Scarborough]
    uint8 constant IMAGE_vnd_airzip_accelerator_azv = 46; // [Gary_Clueit]
    uint8 constant IMAGE_vnd_cns_inf2 	            = 47; // [Ann_McLaughlin]
    uint8 constant IMAGE_vnd_dece_graphic 	        = 48; // [Michael_A_Dolan]
    uint8 constant IMAGE_vnd_djvu	                = 49; // [Leon_Bottou]
    uint8 constant IMAGE_vnd_dwg	                = 50; // [Jodi_Moline]
    uint8 constant IMAGE_vnd_dxf	                = 51; // [Jodi_Moline]
    uint8 constant IMAGE_vnd_dvb_subtitle 	 	    = 52; // [Peter_Siebert][Michael_Lagally]
    uint8 constant IMAGE_vnd_fastbidsheet	 	    = 53; // [Scott_Becker]
    uint8 constant IMAGE_vnd_fpx	 	            = 54; // [Marc_Douglas_Spencer]
    uint8 constant IMAGE_vnd_fst	 	            = 55; // [Arild_Fuldseth]
    uint8 constant IMAGE_vnd_fujixerox_edmics_mmr 	= 56; // [Masanori_Onda]
    uint8 constant IMAGE_vnd_fujixerox_edmics_rlc 	= 57; // [Masanori_Onda]
    uint8 constant IMAGE_vnd_globalgraphics_pgb 	= 58; // [Martin_Bailey]
    uint8 constant IMAGE_vnd_microsoft_icon 	 	= 59; // [Simon_Butcher]
    uint8 constant IMAGE_vnd_mix	         	    = 60; // [Saveen_Reddy]
    uint8 constant IMAGE_vnd_ms_modi 	     	    = 61; // [Gregory_Vaughan]
    uint8 constant IMAGE_vnd_mozilla_apng 	 	    = 62; // [Stuart_Parmenter]
    uint8 constant IMAGE_vnd_net_fpx 	     	    = 63; // [Marc_Douglas_Spencer]
    uint8 constant IMAGE_vnd_pco_b16 	     	    = 64; // [PCO_AG][Jan_Zeman]
    uint8 constant IMAGE_vnd_radiance	     	    = 65; // [Randolph_Fritz][Greg_Ward]
    uint8 constant IMAGE_vnd_sealed_png 	     	= 66; // [David_Petersen]
    uint8 constant IMAGE_vnd_sealedmedia_softseal_gif = 67; // [David_Petersen]
    uint8 constant IMAGE_vnd_sealedmedia_softseal_jpg = 68; // [David_Petersen]
    uint8 constant IMAGE_vnd_svf	 	            = 69; // [Jodi_Moline]
    uint8 constant IMAGE_vnd_tencent_tap 	 	    = 70; // [Ni_Hui]
    uint8 constant IMAGE_vnd_valve_source_texture 	= 71; // [Henrik_Andersson]
    uint8 constant IMAGE_vnd_wap_wbmp 	 	        = 72; // [Peter_Stark]
    uint8 constant IMAGE_vnd_xiff	     	        = 73; // [Steven_Martin]
    uint8 constant IMAGE_vnd_zbrush_pcx 	 	    = 74; // [Chris_Charabaruk]
    uint8 constant IMAGE_wmf 	 	                = 75; // [RFC7903]
    uint8 constant IMAGE_x_emf                      = 76; // - DEPRECATED in favor of image/emf 	image/emf 	[RFC7903]
    uint8 constant IMAGE_x_wmf                      = 77; // - DEPRECATED in favor of image/wmf 	image/wmf 	[RFC7903]    
}