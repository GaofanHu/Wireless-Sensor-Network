import java.util.*;

int n = 256000;
int a = 64;
String shape = new String();
double r;
int number_edge = 0;
float Avg_Deg;
int Max_Deg = 0;
int Min_Deg = Integer.MAX_VALUE;
vertex[] points = new vertex[n];



class vertex{
    float x;
    float y;
    int Degree = 0;
    int ori_Deg = 0;
    boolean del = false;
    int v_color = 0;
    ArrayList<vertex> adja = new ArrayList<vertex>();
    // using an Arraylist to store node's neighbors. Like an adjacency list.

    vertex(float x, float y){     //this is for square and disk
        this.x = x;
        this.y = y;
    }

    boolean isDel(){
        if(this.del){
            return true;
        }
        return false;
    }
}


    void setup(){
        size(750,750);
        stroke(255);
        noLoop();
    }



    void draw(){
        background(255,255,255);

        
        shape = "disk";


        if(shape == "square"){
            r = (Math.sqrt((a/(n * Math.PI)))) * 750;
            System.out.println("Estimated radius value:" + r / (float)750);
            for(int i = 0; i < n; i++){
                points[i] = new vertex(random(750), random(750));
                //strokeWeight(2);
                //stroke(100,100,100);
                point(points[i].x, points[i].y);
                //noStroke();
            }
        }else if(shape == "disk"){
            r = (Math.sqrt((double)a / n)) * 750;
            System.out.println("Estimated radius value:" + r / (float)750);
            
             for(int i = 0; i < n; ){
                 float x = random(750);
                 float y = random(750);
                 if(Math.pow((x - 375), 2) + Math.pow((y - 375), 2) <= Math.pow(375, 2)){
                     points[i] = new vertex(x, y);
                     //strokeWeight(2);
                     //stroke(100,100,100);
                     point(x, y);
                     //noStroke();
                     i++;
                 }
             }
            r = r / 2;
        }
        
        HashMap<Integer, ArrayList<vertex>> cell_points = new HashMap<Integer, ArrayList<vertex>>();

        int num_side = (int)(750 / r) + 1;      //cell
        for(int i = 1; i <= Math.pow(num_side, 2); i++){
            cell_points.put(i, new ArrayList<vertex>());
        }

        for(vertex v: points){
            int index_cell = (int) (v.x / r) + 1 + ((int) (v.y / r)) * num_side;
            cell_points.get(index_cell).add(v);
        }

        long startTime1 = System.currentTimeMillis();    // start time

        long startTime4 = System.currentTimeMillis();
        
        for(int index = 1; index <= Math.pow(num_side, 2); index++){
            if(!cell_points.containsKey(index)) {
                continue;
            }
            for(int i = 0; i < cell_points.get(index).size(); i++){
                int[] num_cell;
                if(index == Math.pow(num_side, 2)){
                    num_cell = new int[]{index};
                }else if(index < num_side){
                    num_cell = new int[]{index, index + 1, index + num_side, index + num_side + 1};
                }else if(index % num_side == 0){
                    num_cell = new int[]{index, index + num_side};
                }else if(index / num_side == num_side - 1){
                    num_cell = new int[]{index, index + 1, index + 1 - num_side};
                }else{
                    num_cell = new int[]{index, index + 1, index + 1 - num_side, index + num_side, index + 1 + num_side};
                }

                for(int m = 0; m < num_cell.length; m++){
                    int j = m == 0? i + 1 : 0;

                    for( ; j < cell_points.get(num_cell[m]).size(); j++){
                        if(dist(cell_points.get(index).get(i).x, cell_points.get(index).get(i).y,
                                cell_points.get(num_cell[m]).get(j).x, cell_points.get(num_cell[m]).get(j).y) <= r){
                            cell_points.get(index).get(i).Degree++;
                            cell_points.get(num_cell[m]).get(j).Degree++;
                            cell_points.get(index).get(i).ori_Deg++;
                            cell_points.get(num_cell[m]).get(j).ori_Deg++;
                            cell_points.get(index).get(i).adja.add(cell_points.get(num_cell[m]).get(j));
                            cell_points.get(num_cell[m]).get(j).adja.add(cell_points.get(index).get(i));
                            //strokeWeight(1);
                            //stroke(100,100,100);
                            //line(cell_points.get(index).get(i).x, cell_points.get(index).get(i).y,
                            //    cell_points.get(num_cell[m]).get(j).x, cell_points.get(num_cell[m]).get(j).y);
                        }
                    }
                }
            }
        }
        
        long endTime1 = System.currentTimeMillis();    // end time

        System.out.println("Part1 Running time:" + (endTime1 - startTime1) + "ms");

        int max_degree_point = -1;
        int min_degree_point = -1;

        for(int i = 0; i < n; i++){

            number_edge = number_edge + points[i].Degree;
            // sum up all degree as the number of all edges. And divided by 2 as below

            if(points[i].Degree > Max_Deg){ // this is for the max degree
                Max_Deg = points[i].Degree;
                max_degree_point = i;
            }
            if(points[i].Degree < Min_Deg){ // this is for the min degree
                Min_Deg = points[i].Degree;
                min_degree_point = i;
            }
        }

        //strokeWeight(20);
        //stroke(255, 0,0);
        //point(points[max_degree_point].x, points[max_degree_point].y);
        //strokeWeight(30);
        //stroke(0, 0, 255);
        //point(points[min_degree_point].x, points[min_degree_point].y);
        //noStroke();

        int[] distribution = new int[Max_Deg + 1]; // this is for the degree distribution chart
        for(int i = 0; i < n; i++){
            distribution[points[i].Degree]++;
        }

        Avg_Deg = (float)number_edge / (float)n;  // this is average degree

        number_edge = number_edge / 2;    // this is the number of edges



        System.out.println("Number of edges:" + number_edge);
        System.out.println("Average degree:" + Avg_Deg);
        System.out.println("Max degree = " + Max_Deg);
        System.out.println("Min degree = " + Min_Deg);




        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2
        //Part2

        HashMap<Integer, ArrayList<vertex>> deg_points = new HashMap<Integer, ArrayList<vertex>>();

        for(vertex v: points){
            if(deg_points.containsKey(v.Degree)){
                deg_points.get(v.Degree).add(v);
            }else{
                ArrayList<vertex> li = new ArrayList<vertex>();
                li.add(v);
                deg_points.put(v.Degree, li);
            }
        }

        PrintWriter output0 = createWriter("Degree Distribution.csv");

        for(int i = 0; i <= Max_Deg; i++) {
          if(deg_points.containsKey(i)){
            output0.println(i + "," + deg_points.get(i).size());
          }else{
            output0.println(i + "," + 0);
          }
        }  

        output0.flush();
        output0.close();


        vertex[] small_last_points = new vertex[points.length];

        int max_deg_when_del = 0;

        long startTime2 = System.currentTimeMillis();    // start time

        boolean flag_clique = true;  

        for(int count = n; count != 0; count--){
            for(int i = 0; i < n; i++){    //find smallest degree in hashmap
                if(!deg_points.containsKey(i)){
                    continue;
                }
                if(deg_points.get(i).size() == 0){
                  continue;
                }
                if(flag_clique && deg_points.size() == 1){
                  int clique = deg_points.get(i).size();
                  flag_clique = false;
                  System.out.println("clique size:" + clique);
                }
                int deg_when_del = 0;
                int size = deg_points.get(i).size();
                vertex p = deg_points.get(i).get(size - 1);

                deg_points.get(i).remove(size - 1);
                p.del = true;
                
                small_last_points[count - 1] = p;

                for(int j = 0; j < p.adja.size(); j++){
                    vertex nei = p.adja.get(j);
                    if(!nei.isDel()){
                        int index = deg_points.get(nei.Degree).indexOf(nei);
                        deg_points.get(nei.Degree).remove(index);

                        if(deg_points.get(nei.Degree).size() == 0){
                          deg_points.remove(nei.Degree);
                        }

                        nei.Degree--;

                        if(deg_points.containsKey(nei.Degree)){
                            deg_points.get(nei.Degree).add(nei);
                        }else{
                            ArrayList<vertex> li = new ArrayList<vertex>();
                            li.add(nei);
                            deg_points.put(nei.Degree, li);
                        }

                        deg_when_del++;
                    }
                }

                if(deg_when_del > max_deg_when_del){
                    max_deg_when_del = deg_when_del;
                }

                if(deg_points.containsKey(i) && deg_points.get(i).size() == 0){
                    deg_points.remove(i);
                }

                break;
            }
        }

       PrintWriter output1 = createWriter("Deg_when_del & ori_deg.csv");

      for(int i = 0; i < n; i++) {
        output1.println(i + "," + points[i].ori_Deg + "," + points[i].Degree);
      }  

      output1.flush();
      output1.close();

        
        
        System.out.println("max degree_when_deleted:  " + max_deg_when_del);
        
        //HashMap<Integer, ArrayList<vertex>> color_count = new HashMap<Integer, ArrayList<vertex>>();
        HashMap<Integer, Set<vertex>> color_count = new HashMap<Integer, Set<vertex>>();
        small_last_points[0].v_color = 1;
        //ArrayList<vertex> temp_co = new ArrayList<vertex>();
        //temp_co.add(small_last_points[0]);
        //color_count.put(1,temp_co);
        Set<vertex> temp_co = new HashSet<vertex>();
        temp_co.add(small_last_points[0]);
        color_count.put(1, temp_co);

        for(int i = 1; i < n; i++){
            int l = small_last_points[i].adja.size() - 1;
            Set<Integer> eachcolor = new HashSet<Integer>();

            while(l >= 0){
                eachcolor.add(small_last_points[i].adja.get(l).v_color);
                l--;
            }

            for(int j = 1; ;j++){
                if(!eachcolor.contains(j)){
                    small_last_points[i].v_color = j;
                    if(color_count.containsKey(j)){
                      color_count.get(j).add(small_last_points[i]);
                    }else{
                        //ArrayList<vertex> temp = new ArrayList<vertex>();
                        //temp.add(small_last_points[i]);
                        //color_count.put(1,temp);
                        Set<vertex> temp = new HashSet<vertex>();
                        temp.add(small_last_points[i]);
                        color_count.put(j, temp);
                    }
                    break;
                }
            }
        }
        long endTime2 = System.currentTimeMillis();    // end time

        System.out.println("part2 Running time:" + (endTime2 - startTime2) + "ms");

        int num_color = 0;
        int max_colorsize = 0;
        
        for (Map.Entry c : color_count.entrySet()) {
            if (((Set)c.getValue()).size() != 0) {
                num_color++;
                if(max_colorsize < ((Set)c.getValue()).size()){
                    max_colorsize = ((Set)c.getValue()).size();
                }
            }
        }

        PrintWriter output2 = createWriter("color set size distribution.csv");

        for(int i = 1; i <= num_color; i++) {
          output2.println(i + "," + color_count.get(i).size());
        }  

        output2.flush();
        output2.close();

        System.out.println("number of colors:      " + num_color);
        System.out.println("max color set size:  " + max_colorsize);








        //part3
        //part3
        //part3
        //part3        
        //part3
        //part3
        //part3        
        //part3
        //part3
        //part3        
        //part3
        //part3
        //part3       
        //part3
        //part3
        //part3        
        //part3
        //part3
        //part3        
        //part3
        //part3
        //part3


        ArrayList<Integer> maxfour = new ArrayList<Integer>();

        for(int i = 0; i < 4; i++){
            int maxset = 0;
            int maxkey = 0;
            for(Map.Entry c: color_count.entrySet()){
                if(((Set)c.getValue()).size() > maxset){
                    if(!maxfour.contains((Integer)c.getKey())){
                        maxset = ((Set)c.getValue()).size();
                        maxkey = (Integer)c.getKey();
                    }
                }
            }
            maxfour.add(maxkey);
        }

        ArrayList<ArrayList<Integer>> max_pair = new ArrayList<ArrayList<Integer>>();

        ArrayList<Integer> pair1 = new ArrayList<Integer>();
        ArrayList<Integer> pair2 = new ArrayList<Integer>();
        ArrayList<Integer> pair3 = new ArrayList<Integer>();
        ArrayList<Integer> pair4 = new ArrayList<Integer>();
        ArrayList<Integer> pair5 = new ArrayList<Integer>();
        ArrayList<Integer> pair6 = new ArrayList<Integer>();

        pair1.add(maxfour.get(0));
        pair1.add(maxfour.get(1));

        pair2.add(maxfour.get(0));
        pair2.add(maxfour.get(2));

        pair3.add(maxfour.get(0));
        pair3.add(maxfour.get(3));

        pair4.add(maxfour.get(1));
        pair4.add(maxfour.get(2));

        pair5.add(maxfour.get(1));
        pair5.add(maxfour.get(3));

        pair6.add(maxfour.get(2));
        pair6.add(maxfour.get(3));

        max_pair.add(pair1);
        max_pair.add(pair2);
        max_pair.add(pair3);
        max_pair.add(pair4);
        max_pair.add(pair5);
        max_pair.add(pair6);


        int[] index_max_six = new int[6];

        ArrayList<ArrayList<ArrayList<vertex>>> six_backbone_list = new ArrayList<ArrayList<ArrayList<vertex>>>();

        ArrayList<ArrayList<Integer>> six_backbone_edge_num = new ArrayList<ArrayList<Integer>>();

    long startTime3 = System.currentTimeMillis();

        for(int i = 0; i < 6; i++){

            Set s1 = color_count.get(max_pair.get(i).get(0));
            Set s2 = color_count.get(max_pair.get(i).get(1));

            Queue<vertex> queue = new LinkedList<vertex>();

            boolean flag = true;

            ArrayList<vertex> used_v = new ArrayList<vertex>();

            ArrayList<ArrayList<vertex>> backbone_list = new ArrayList<ArrayList<vertex>>();

            ArrayList<Integer> backbone_edge_num = new ArrayList<Integer>();

            for(Object v2: s1){
                vertex v1 = (vertex)v2; 

                if(used_v.contains(v1)){      

                    //used_v里只用存s1里面的

                    continue;
                }

                ArrayList<vertex> path = new ArrayList<vertex>();

                int num_edge_backbone = 0;

                path.add(v1);

                queue.offer(v1);

                while(!queue.isEmpty()){

                    int size = queue.size();

                    for(int m = 0; m < size; m++){
                        vertex v = queue.poll();

                        if(flag){
                            num_edge_backbone = addtopath(s2, v, path, queue, flag, used_v, num_edge_backbone);
                        }else{
                            num_edge_backbone = addtopath(s1, v, path, queue, flag, used_v, num_edge_backbone);
                        }
                    }

                    flag = !flag;
                }

                backbone_list.add(path);

                backbone_edge_num.add(num_edge_backbone / 2);

            }

            six_backbone_list.add(backbone_list);

            six_backbone_edge_num.add(backbone_edge_num);

            int max_edge_backbone = 0;

            int index_max = -1;

            for(int j = 0; j < backbone_edge_num.size(); j++){
                if(backbone_edge_num.get(j) > max_edge_backbone){
                    max_edge_backbone = backbone_edge_num.get(j);
                    index_max = j;
                }
            }
            // System.out.println("vertex:"+backbone_list.get(index_max).size());

            // System.out.println(max_edge_backbone);

            index_max_six[i] = index_max;
        }

        long endTime3 = System.currentTimeMillis();    // end time

        System.out.println("Running time:" + (endTime3 - startTime3) + "ms");

        long endTime4 = System.currentTimeMillis();    // end time
        System.out.println("Total running time:" + (endTime4 - startTime4) + "ms"); 

        int skip_max = -1;

        int temp = -1;
        
        int draw_flag = 0;

        for(int i = 0; i < 2; i++){
            int max_two_backbone_num = -1;

            for(int j = 0; j < 6; j++){
                if(skip_max == j){
                    continue;
                }

                if(max_two_backbone_num < six_backbone_edge_num.get(j).get(index_max_six[j])){
                    max_two_backbone_num = six_backbone_edge_num.get(j).get(index_max_six[j]);
                    temp = j;
                }
            }

            skip_max = temp;
            // max_two[i] = temp;
            // System.out.println(max_two[i]);
            System.out.println("The colors of the two independent sets in backbone " 
              + (i + 1) + ": " + max_pair.get(temp).get(0) + "," + max_pair.get(temp).get(1));

            System.out.println("Number of vertices in backbone " + (i + 1) + ": " + 
              six_backbone_list.get(temp).get(index_max_six[temp]).size());

          Set<vertex> domination = new HashSet<vertex>();

          for(vertex v: six_backbone_list.get(temp).get(index_max_six[temp])){
            domination.add(v);
            for(vertex v1: v.adja){
              domination.add(v1);
            }
          }     

          double coverage = (double)domination.size() / (double) n;

          System.out.println("Percentage of sensors covered by the backbone" + (i + 1) + ": "+ coverage * 100 + "%");       
          System.out.println("Number of edges in backbone " + (i + 1) + ": " + max_two_backbone_num);

          ArrayList<vertex> draw_list = six_backbone_list.get(temp).get(index_max_six[temp]);
          int color_set1 = max_pair.get(temp).get(0);
          int color_set2 = max_pair.get(temp).get(1);

          Set<vertex> drawed = new HashSet<vertex>();
          
         //  for(vertex v: draw_list){
         //    if(color_count.get(color_set1).contains(v)){
         //        for(vertex v_n: v.adja){
         //            if(color_count.get(color_set2).contains(v_n) && !drawed.contains(v_n)){
         //                strokeWeight(1);
         //                stroke(0);
         //                line(v.x, v.y, v_n.x, v_n.y);
         //                noStroke();                                                                                                 
         //            }
         //        }
         //        strokeWeight(7);
         //        stroke(77,187,170);
         //        point(v.x, v.y);
         //        noStroke();
         //    }else{
         //        for(vertex v_n: v.adja){
         //            if(color_count.get(color_set1).contains(v_n) && !drawed.contains(v_n)){
         //                strokeWeight(1);
         //                stroke(0);
         //                line(v.x, v.y, v_n.x, v_n.y);
         //                noStroke();
         //            }
         //        }
         //        strokeWeight(7);
         //        stroke(110,63,0);
         //        point(v.x, v.y);
         //        noStroke();
         //    }
         //    drawed.add(v);
         //  }
          
         //  if(draw_flag == 0){
         //    saveFrame("backbone1.jpg");

         //    noFill();
         //    background(255,255,255);
         //    draw_flag = 1;
         //  }
         }
  
    }


    int addtopath(Set s2, vertex v, ArrayList<vertex> path, 
        Queue<vertex> queue, boolean flag, ArrayList<vertex> used_v,
        int num_edge_backbone){

        for(int i = 0; i < v.adja.size(); i++){

            if(s2.contains(v.adja.get(i))){

                num_edge_backbone++;

                if(!path.contains(v.adja.get(i))){

                    queue.offer(v.adja.get(i));

                    path.add(v.adja.get(i));

                    if(!flag){
                        used_v.add(v.adja.get(i));
                    }

                }
                
            }
        }

        return num_edge_backbone; 
    }
