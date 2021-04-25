#!/usr/bin/env bash

#对jpeg格式图片进行图片质量压缩
function jpeg_compress {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "jpeg" ]];then
	        convert "$img" -quality "$1" "$img"
		    echo "jpeg_compress success:quality $1"
        fi
	done
}

#对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
function img_resize {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];then
            convert "${img}" -resize "$1" "${img}"
		    echo "img_resize success"
        fi
	done
}

#对图片批量添加自定义文本水印
function img_watermarking {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];then
            convert "${img}" -pointsize "$1" -draw "text 0,20 '$2'" "${img}"
		    echo "img_watermarking success"
        fi
	done
}

#批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）

#前缀
function add_prefix {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];then
            mv "${img}" "$1""${img}"
		    echo "add_prefix success"
        fi
	done
}

#后缀
function add_suffix {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];then
            newname=${img%.*}$1"."${type}
            mv "${img}" "${newname}"
		    echo "add_suffix success"
        fi
	done
}

#将png/svg图片统一转换为jpg格式图片
function type_transform {
    for img in *;do
        type=${img##*.}
        if [[ ${type} == "png" || ${type} == "svg" ]];then
            new=${img%.*}".jpeg"
            convert "${img}" "${new}"
		    echo "type_transform success"
        fi
	done
}

#help文档
function help {
    echo "-q Q               对jpeg格式图片进行图片质量压缩"
    echo "-r R               对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
    echo "-w font_size text  对图片批量添加自定义文本水印"
    echo "-p text            统一添加文件名前缀"
    echo "-s text            统一添加文件名后缀"
    echo "-t                 将png/svg图片统一转换为jpg格式图片"
    echo "-h                 帮助文档"
}

if [ "$1" != "" ];then
    case "$1" in
        "-q")
            jpeg_compress "$2"
            exit 0
            ;;
        "-r")
            img_resize "$2"
            exit 0
            ;;
        "-w")
            img_watermarking "$2" "$3"
            exit 0
            ;;
        "-p")
            add_prefix "$2"
            exit 0
            ;;
        "-s")
            add_suffix "$2"
            exit 0
            ;;
        "-t")
            type_transform
            exit 0
            ;;
        "-h")
            help
            exit 0
            ;;
    esac
fi
