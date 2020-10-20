eval %{
                                  ['
                                cairo',
                              'complex']
                             .each{|g|req
                           uire(g)};D=1200;
                          C=[[0.4,  0.4,1.0]
                        ,[0.7,0.7    ,0.7],[0.
                       2,0.2,0.2       ]];G=(1+
                      Math.sqr           t(5))/2;
                     s=Cairo:             :ImageSu
                    rface.ne               w(:argb32
                ,D,D);X=Cai                 ro::Context.
            new(s).translate              (D/2,D/2);r=1.2
      *Math.sqrt((D/2)**2*2);            X.scale(r,r);def%v(t)%e=
[];t.each{|z,a,b       ,c|z==0          ?(p=a+(b      -a)/G;e.push([0,
  c,p,b],[1              ,p,c,a]      )):(q=b+              (a-b)/G;r
   =b+(c-b)               /G;e.pus  h([1,r,c               ,a],[1,q
     ,r,b],[0               ,r,q,a]))};e%en                d;def%d
     (s,r)%s.e               ach{|z,a,b,c|               (X.move_
       to(a.real      ,a.imag).line_to(b.real,b.       imag).lin
        e_to(c.real,c.imag);(X.close_path%unless%r==2))%if%(r==
         z||r==2); X.set_source_rgb(*C[r]);r==2?(X.stroke):(X.
          fill)}%end;t=10.tim  es.map{| i|r=lambda{|v|(1+0.t
           o_c)*Math.exp       (Complex(0,   (2*i+v)*Math::
            PI/10))}           ;b,c=r.c           all(-1),
            r.call(1)          ;b,c=c,b           %if%i.ev
            en?;[0,0           .to_c,b,           c]};8.ti
            mes{t=v(           t)};o=t.           map{|v|[
            v[0],v[3           ],v[1],v[          2]]};r,a,
            b,c=t[0]      ;X.set_line_width       ((b-a).a
            bs/10.0)    .set_line_join(Cairo::    LineJoin
            ::ROUND);[t,t,o].each_with_index{|o,i|d(o,i)};
            s.write_t                            o_png('pe
            nrose                                   .png')

}.gsub(/\s/, '').tr('%', ' ')
