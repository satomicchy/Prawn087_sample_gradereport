# -*- coding: utf-8 -*-
class ExamineeReport < Prawn::Document
  def to_pdf(examination, summary, examinee, score)

    font_families.update("Kanjikana" => {
                           :normal => "#{Prawn::BASEDIR}/data/fonts/VL-Gothic-Regular.ttf",
                           :bold   => "#{Prawn::BASEDIR}/data/fonts/MigMix-2P-bold.ttf"
                         })
    font "Kanjikana"
    head_color = "C4C4C4"

    # /header/
    text_box "日本語教育能力検定試験", :at => [5, 800], :size => 10
    text_box "2011年9月4日",         :at => [470, 800], :size => 10
    text  "<b>2011年度全国統一公開模擬試験　結果</b>", :inline_format => true, :align => :center, :size => 15
    move_down 10

    text "受験番号 #{examinee.number}      氏 名 #{examinee.name}"
    move_down 10

    # /body/
    # top table
    head = [["試験Ⅰ", "#{score.exam1_totalscore}点", "#{score.exam1_totaldeviation/100.0}", "#{score.exam1_totalrank}位", "",
             "#{summary.exam1_ave/100.0}", "#{summary.exam1_max}", "#{summary.exam1_min}", "#{summary.exam1_sd/100.0}",
             "#{summary.exam1_20percent}点(#{summary.exam1_percent_rank}位)", "#{summary.examinee_count}人"],
            ["試験Ⅱ", "#{score.exam2_totalscore}点", "#{score.exam2_totaldeviation/100.0}", "#{score.exam2_totalrank}位", "",
             "#{summary.exam2_ave/100.0}", "#{summary.exam2_max}", "#{summary.exam2_min}", "#{summary.exam2_sd/100.0}",
             "#{summary.exam2_20percent}点(#{summary.exam2_percent_rank}位)", "#{summary.examinee_count}人"],
            ["試験Ⅲ", "#{score.exam3_totalscore}点", "#{score.exam3_totaldeviation/100.0}", "#{score.exam3_totalrank}位", "",
             "#{summary.exam3_ave/100.0}", "#{summary.exam3_max}", "#{summary.exam3_min}", "#{summary.exam3_sd/100.0}",
             "#{summary.exam3_20percent}点(#{summary.exam3_percent_rank}位)", "#{summary.examinee_count}人"],
            ["総　合", "#{score.total_score}点", "#{score.total_deviation/100.0}", "#{score.total_rank}位", "",
             "#{summary.total_ave/100.0}", "#{summary.total_max}", "#{summary.total_min}", "#{summary.total_sd/100.0}",
             "#{summary.total_20percent}点(#{summary.total_percent_rank}位)", "#{summary.examinee_count}人"]]
    table head,
          :border_style => :grid,
          :position => :center,
          :font_size => 10,
          :headers => ["", "得点", "偏差値", "順位", "", "平均点", "最高点", "最低点", "標準偏差", "上位約2割点", "受験者数"],
          :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50, 4 => 2, 5 => 50, 6 => 40, 7 => 40, 8 => 60, 9 => 70, 10 => 60},
          :align_headers => :center,
          :header_color => head_color,
          :align => :right,
          :column_height => 16,
          :vertical_padding => 2,
          :horizontal_padding => 5
    move_down 10

    # left table
    # left table top
    cell [0,670],
         :text => "試験Ⅰ (100点満点)",
         :font_size => 10,
         :width => 204,
         :background_color => head_color,
         :vertical_padding => 2,
         :horizontal_padding => 5
    title2line = [["問", "マ／ク", "得点", "正答率", "問", "マ／ク", "得点", "正答率"]]
    table title2line,
          :border_style => :grid,
          :position => :left,
          :font_size => 9,
          :column_widths => {0 => 51, 1 => 17, 2 => 17, 3 => 17, 4 => 51, 5 => 17, 6 => 17, 7 => 17},
          :row_colors => {0 => head_color, 1 => head_color, 2 => head_color, 3 => head_color,
                          4 => head_color, 5 => head_color, 6 => head_color, 7 => head_color},
          :align => :center,
          :vertical_padding => 1,
          :horizontal_padding => 1

    # left number1
    cell [0,627], :font_size => 9, :align => :center, :width => 17,
         :text => "1",
         :height => 165
    bounding_box [17,627], :width => 34, :height => 165 do
      sub = []
      1.upto(15){|n| sub << ["(#{n})"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number2
    cell [0,462], :font_size => 9, :align => :center, :width => 17,
         :text => "2", :height => 55
    bounding_box [17,462], :width => 34, :height => 55 do
      sub = []
      1.upto(5){|n| sub << ["(#{n})"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number3
    cell [0,407], :font_size => 9, :align => :center, :width => 17,
         :text => "3", :height => 264
    cell [17,407], :font_size => 9, :align => :center, :width => 14,
         :text => "A", :height => 33
    4.times{|i|
      y = 374 - i * 44
      text_strings = ["B", "C", "D", "E"]
      cell [17, y], :font_size => 9, :align => :center, :width => 14,
           :text => "#{text_strings[i]}", :height => 44
    }
    cell [17,198], :font_size => 9, :align => :center, :width => 14,
         :text => "F", :height => 55
    bounding_box [31,407], :width => 34, :height => 264 do
      sub = []
      1.upto(24){|n| sub << ["(#{n})"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 20},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number4
    cell [0,143], :font_size => 9, :align => :center, :width => 17,
         :text => "4", :height => 55
    bounding_box [17,143], :width => 34, :height => 55 do
      sub = []
      1.upto(5){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number5
    cell [102,627], :font_size => 9, :align => :center, :width => 17,
         :text => "5", :height => 44
    bounding_box [119,627], :width => 34, :height => 44 do
      sub = []
      1.upto(4){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number6
    cell [102,583], :font_size => 9, :align => :center, :width => 17,
         :text => "6",  :height => 77
    bounding_box [119,583], :width => 34, :height => 77 do
      sub = []
      1.upto(7){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number7
    cell [102,506], :font_size => 9, :align => :center, :width => 17,
         :text => "7",  :height => 88
    cell [119,506], :font_size => 9, :align => :center, :width => 17,
         :text => "問1",  :height => 33
    cell [136,506], :font_size => 9, :align => :center, :width => 17,
         :text => "ア",  :height => 11
    cell [136,495], :font_size => 9, :align => :center, :width => 17,
         :text => "イ",  :height => 11
    cell [136,484], :font_size => 9, :align => :center, :width => 17,
         :text => "エ",  :height => 11
    bounding_box [119,473], :width => 34, :height => 55 do
      sub = []
      2.upto(6){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number8
    cell [102,418], :font_size => 9, :align => :center, :width => 17,
         :text => "8",  :height => 44
    bounding_box [119,418], :width => 34, :height => 44 do
      sub = []
      1.upto(4){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number9,10,11,12
    4.times{|i|
      y = 374 - i * 55
      cell [102, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 9}",  :height => 55
      bounding_box [119, y], :width => 34, :height => 55 do
        sub = []
        1.upto(5){|n| sub << ["問#{n}"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # left number13
    cell [102,154], :font_size => 9, :align => :center, :width => 17,
         :text => "13", :height => 33
    bounding_box [119,154], :width => 34, :height => 33 do
      sub = []
      1.upto(3){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left number14
    cell [102,121], :font_size => 9, :align => :center, :width => 17,
         :text => "14", :height => 55
    bounding_box [119,121], :width => 34, :height => 55 do
      sub = []
      1.upto(5){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # left data
    exam1_examineeanswers = FasterCSV.parse_line(score.exam1_examineeanswer).map{|n| (n == "0") ? "-" : n}
    exam1_examineescores  = FasterCSV.parse_line(score.exam1_examineescore)
    exam1_correct_percent = FasterCSV.parse_line(summary.exam1_correct_percent)
    bounding_box [51,627], :width => 51, :height => 539 do
      data = []
      0.upto(48){|n| data << [exam1_examineeanswers[n], exam1_examineescores[n], exam1_correct_percent[n]]}
      table data,
            :border_style => :grid,
            :font_size => 9,
            :column_widths => {0 => 17, 1 => 17, 2 => 17},
            :align => :center,
            :vertical_padding => 1,
            :horizontal_padding => 1
    end
    bounding_box [153,627], :width => 51, :height => 561 do
      data = []
      49.upto(99){|n| data << [exam1_examineeanswers[n], exam1_examineescores[n], exam1_correct_percent[n]]}
      table data,
            :border_style => :grid,
            :font_size => 9,
            :column_widths => {0 => 17, 1 => 17, 2 => 17},
            :align => :center,
            :vertical_padding => 1,
            :horizontal_padding => 1
    end

    # center table
    # center table top
    cell [220,670],
         :text => "試験Ⅱ (40点満点)",
         :font_size => 10,
         :width => 102,
         :background_color => head_color,
         :vertical_padding => 2,
         :horizontal_padding => 5
    title1line = [["問", "マ／ク", "得点", "正答率"]]
    table title1line,
          :border_style => :grid,
          :position => 220,
          :font_size => 9,
          :column_widths => {0 => 51, 1 => 17, 2 => 17, 3 => 17},
          :row_colors => {0 => head_color, 1 => head_color, 2 => head_color, 3 => head_color},
          :align => :center,
          :vertical_padding => 1,
          :horizontal_padding => 1

    # center number1,2
    2.times{|i|
      y = 627 - i * 66
      cell [220, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 1}",
           :height => 66
      bounding_box [237, y], :width => 34, :height => 66 do
        sub = []
        1.upto(6){|n| sub << ["#{n}番"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # center number3
    cell [220,495], :font_size => 9, :align => :center, :width => 17,
         :text => "3",
         :height => 88
    bounding_box [237,495], :width => 34, :height => 88 do
      sub = []
      1.upto(8){|n| sub << ["#{n}番"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # center number4
    cell [220,407], :font_size => 9, :align => :center, :width => 17,
         :text => "4",
         :height => 88
    1.upto(4){|n|
      y = 407 - (n - 1) * 22
      cell [237, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{n}番",
           :height => 22
    }
    bounding_box [254,407], :width => 17, :height => 88 do
      sub = []
      1.upto(2){|n| sub << ["問#{n}"]}
      4.times{
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 17},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      }
    end

    # center number5
    cell [220,319], :font_size => 9, :align => :center, :width => 17,
         :text => "5",
         :height => 55
    cell [237,319], :font_size => 9, :align => :center, :width => 17,
         :text => "1番",
         :height => 33
    cell [237,286], :font_size => 9, :align => :center, :width => 17,
         :text => "2番",
         :height => 22
    bounding_box [254,319], :width => 17, :height => 33 do
      sub = []
      1.upto(3){|n| sub << ["#{n}番"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 17},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end
    bounding_box [254,286], :width => 17, :height => 22 do
      sub = []
      1.upto(2){|n| sub << ["#{n}番"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 17},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # center number6
    cell [220,264], :font_size => 9, :align => :center, :width => 17,
         :text => "6",
         :height => 77
    bounding_box [237,264], :width => 34, :height => 77 do
      sub = []
      1.upto(7){|n| sub << ["#{n}番"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # center data
    exam2_examineeanswers = FasterCSV.parse_line(score.exam2_examineeanswer).map{|n| n.tr("0-4", "-a-d")}
    exam2_examineescores  = FasterCSV.parse_line(score.exam2_examineescore)
    exam2_correct_percent = FasterCSV.parse_line(summary.exam2_correct_percent)
    bounding_box [271,627], :width => 51, :height => 440 do
      data = []
      0.upto(39){|n| data << [exam2_examineeanswers[n, 1], exam2_examineescores[n], exam2_correct_percent[n]]}
      table data,
            :border_style => :grid,
            :font_size => 9,
            :column_widths => {0 => 17, 1 => 17, 2 => 17},
            :align => :center,
            :vertical_padding => 1,
            :horizontal_padding => 1
    end

    # right table
    # right table top
    cell [338,670],
         :text => "試験Ⅲ (100点満点)",
         :font_size => 10,
         :width => 204,
         :background_color => head_color,
         :vertical_padding => 2,
         :horizontal_padding => 5
    title3line = [["問", "マ／ク", "得点", "正答率", "問", "マ／ク", "得点", "正答率"]]
    table title3line,
          :border_style => :grid,
          :position => 338,
          :font_size => 9,
          :column_widths => {0 => 51, 1 => 17, 2 => 17, 3 => 17, 4 => 51, 5 => 17, 6 => 17, 7 => 17},
          :row_colors => {0 => head_color, 1 => head_color, 2 => head_color, 3 => head_color,
                          4 => head_color, 5 => head_color, 6 => head_color, 7 => head_color},
          :align => :center,
          :vertical_padding => 1,
          :horizontal_padding => 1

    # right number1,2
    2.times{|i|
      y = 627 - i * 55
      cell [338, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 1}",
           :height => 55
      bounding_box [355, y], :width => 34, :height => 55 do
        sub = []
        1.upto(5){|n| sub << ["問#{n}"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # right number3
    cell [338, 517], :font_size => 9, :align => :center, :width => 17,
         :text => "3",
         :height => 44
    bounding_box [355, 517], :width => 34, :height => 44 do
      sub = []
      1.upto(4){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number4,5,6
    3.times{|i|
      y = 473 - i * 66
      cell [338, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 4}",
           :height => 66
      bounding_box [355, y], :width => 34, :height => 66 do
        sub = []
        1.upto(6){|n| sub << ["問#{n}"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # right number7,8
    2.times{|i|
      y = 275 - i * 55
      cell [338, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 7}",
           :height => 55
      bounding_box [355, y], :width => 34, :height => 55 do
        sub = []
        1.upto(5){|n| sub << ["問#{n}"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # right number9
    cell [338, 165], :font_size => 9, :align => :center, :width => 17,
         :text => "9",
         :height => 66
    bounding_box [355, 165], :width => 34, :height => 66 do
      sub = []
      1.upto(6){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number10
    cell [440, 627], :font_size => 9, :align => :center, :width => 17,
         :text => "10",
         :height => 44
    bounding_box [457, 627], :width => 34, :height => 44 do
      sub = []
      1.upto(4){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number11
    cell [440, 583], :font_size => 9, :align => :center, :width => 17,
         :text => "11",
         :height => 55
    bounding_box [457, 583], :width => 34, :height => 55 do
      sub = []
      1.upto(5){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number12,13
    2.times{|i|
      y = 528 - i * 66
      cell [440, y], :font_size => 9, :align => :center, :width => 17,
           :text => "#{i + 12}",
           :height => 66
      bounding_box [457, y], :width => 34, :height => 66 do
        sub = []
        1.upto(6){|n| sub << ["問#{n}"]}
        table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                   :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
      end
    }

    # right number14
    cell [440, 396], :font_size => 9, :align => :center, :width => 17,
         :text => "14",
         :height => 55
    bounding_box [457, 396], :width => 34, :height => 55 do
      sub = []
      1.upto(5){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number15
    cell [440, 341], :font_size => 9, :align => :center, :width => 17,
         :text => "15",
         :height => 66
    bounding_box [457, 341], :width => 34, :height => 66 do
      sub = []
      1.upto(6){|n| sub << ["問#{n}"]}
      table sub, :font_size => 9, :align => :center, :column_widths => {0 => 34},
                 :border_style => :grid, :vertical_padding => 1, :horizontal_padding => 1
    end

    # right number16
    cell [440, 275], :font_size => 9, :align => :center, :width => 17,
         :text => "16",
         :height => 11
    cell [457, 275], :font_size => 9, :align => :center, :width => 34,
         :text => "記述",
         :height => 11

    # right data
    exam3_examineeanswers = FasterCSV.parse_line(score.exam3_examineeanswer).map{|n| (n == "0") ? "-" : n}
    exam3_examineescores  = FasterCSV.parse_line(score.exam3_examineescore)
    exam3_correct_percent = FasterCSV.parse_line(summary.exam3_correct_percent)
    bounding_box [389,627], :width => 51, :height => 528 do
      data = []
      0.upto(47){|n| data << [exam3_examineeanswers[n], exam3_examineescores[n], exam3_correct_percent[n]]}
      table data,
            :border_style => :grid,
            :font_size => 9,
            :column_widths => {0 => 17, 1 => 17, 2 => 17},
            :align => :center,
            :vertical_padding => 1,
            :horizontal_padding => 1
    end
    bounding_box [491,627], :width => 51, :height => 352 do
      data = []
      48.upto(79){|n| data << [exam3_examineeanswers[n], exam3_examineescores[n], exam3_correct_percent[n]]}
      table data,
            :border_style => :grid,
            :font_size => 9,
            :column_widths => {0 => 17, 1 => 17, 2 => 17},
            :align => :center,
            :vertical_padding => 1,
            :horizontal_padding => 1
    end
    cell [491, 275], :font_size => 9, :align => :center, :width => 34,
         :text => score.written_score,
         :height => 11


    text_box "題", :at => [21, 645],  :size => 9
    text_box "題", :at => [123, 645], :size => 9
    text_box "題", :at => [241, 645], :size => 9
    text_box "題", :at => [359, 645], :size => 9
    text_box "題", :at => [461, 645], :size => 9
    move_down 10

    # /footer/
    bounding_box [0, 50], :width => 530 do
      text "・上位約２割点は、受験者全体の上位約２割に位置する方の得点・順位です。", :align => :left, :size => 8, :leading => 2
      text "・マーク欄は、読み取った内容をそのまま表示しています。複数マークは表示されません。ーは、複数マークまたはマークなしです。", :align => :left, :size => 8, :leading => 2
      text "・正答率は、正答者の割合(%)です。", :align => :left, :size => 8, :leading => 2
      text "全国統一公開模擬試験実行委員会", :align => :right, :size => 10
    end

    render
  end
end
