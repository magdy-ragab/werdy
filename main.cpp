/* Copyright (c) 2013-2016 Mahmoud Fayed <msfclipper@yahoo.com> */

#include <QApplication>
#include <QFile>

#include "QFile"
#include "QTextStream"

#include <QStandardPaths>
#include <QUrl>

#include <QDir>



// Load Ring

extern "C" {
#include "ring.h"
}

#include "ring_qt.h"

#include "ring_string.c"
#include "ring_item.c"
#include "ring_items.c"
#include "ring_list.c"
#include "ring_scanner.c"
#include "ring_parser.c"
#include "ring_stmt.c"
#include "ring_expr.c"
#include "ring_codegen.c"
#include "ring_vm.c"
#include "ring_vmexpr.c"
#include "ring_vmvars.c"
#include "ring_vmlists.c"
#include "ring_vmfuncs.c"
#include "ring_vmoop.c"
#include "ring_vmcui.c"
#include "ring_vmtrycatch.c"
#include "ring_vmstrindex.c"
#include "ring_vmjump.c"
#include "ring_vmduprange.c"
#include "ring_vmperformance.c"
#include "ring_vmexit.c"
#include "ring_vmstackvars.c"
#include "ring_vmstate.c"
#include "ring_api.c"
#include "ring_vmmath.c"
#include "ring_vmfile.c"
#include "ring_state.c"
#include "ring_vmrefmeta.c"
#include "ring_vmlistfuncs.c"
#include "ring_vmos.c"
#include "ring_ext.c"
#include "ring_hashlib.c"
#include "ring_hashtable.c"
#include "ring_vmgc.c"

int main(int argc, char *argv[])
{
    QApplication a(argc,argv);

    QString path ;
    //path = QStandardPaths::writableLocation(QStandardPaths::DataLocation) ;
    path = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation) ;
    QDir::setCurrent(path);


    /*CreateDirectory("C:\\Users\\magdy\\AppData\\Local\\z\\", NULL);
    CreateDirectory("C:\\Users\\magdy\\AppData\\Local\\z\\includes\\", NULL);
    CreateDirectory("C:\\Users\\magdy\\AppData\\Local\\z\\images\\", NULL);

    QString path ;
    path = "C:\\Users\\magdy\\AppData\\Local\\z\\";
    QDir::setCurrent(path);*/


    // Copy Files from Resources to Temp Folder

    // Add test.ring
    QString path2 ;
    path2 = path+"/test.ring";
    QFile::copy(":/resources/myfile4",path2);

    // Add ring_qt.ring
    QString path3 ;
    path3 = path+"/ring_qt.ring";
    QFile::copy(":/resources/myfile5",path3);

    // Add qt.rh
    QString path4 ;
    path4 = path+"/qt.rh";
    QFile::copy(":/resources/myfile6",path4);

    // Add guilib.ring
    QString path5 ;
    path5 = path+"/guilib.ring";
    QFile::copy(":/resources/myfile7",path5);


/* my files */
    QString path8 ;
    path8 = path+"/quran.db.sqlite";
    QFile::copy(":/resources/quran.db.sqlite",path8);



    QString inc1 ;
    inc1= path+"/fav.wnd.ring";
    QFile::copy(":/resources/fav.wnd.ring",inc1);

    QString inc2 ;
    inc2= path+"/globals.ring";
    QFile::copy(":/resources/globals.ring",inc2);

    QString inc3 ;
    inc3= path+"/snooze.wnd.ring";
    QFile::copy(":/resources/snooze.wnd.ring",inc3);

    QString inc4 ;
    inc4= path+"/sura.ring";
    QFile::copy(":/resources/sura.ring",inc4);

    QString inc5 ;
    inc5= path+"/tafseer.ring";
    QFile::copy(":/resources/tafseer.ring",inc5);

    QString inc6 ;
    inc6= path+"/tafseer.ring";
    QFile::copy(":/resources/wnd.ring",inc6);

    QString inc7 ;
    inc7= path+"/tafseer.ring";
    QFile::copy(":/resources/wrd.wind.ring",inc7);

    QString inc8 ;
    inc8= path+"/wnd.ring";
    QFile::copy(":/resources/wnd.ring",inc8);


    QString inc9 ;
    inc9= path+"/wrd.wind.ring";
    QFile::copy(":/resources/wrd.wind.ring",inc9);







/* images */
    QString img1 ;
    img1 = path+"/islamic-star.png";
    QFile::copy(":/resources/islamic-star.png",img1 );

    QString img2 ;
    img2 = path+"/1464846947_book.png";
    QFile::copy(":/resources/1464846947_book.png",img2 );

    QString img3 ;
    img3 = path+"/1466523816_Info.png";
    QFile::copy(":/resources/1466523816_Info.png",img3 );

    QString img4 ;
    img4 = path+"/add.png";
    QFile::copy(":/resources/add.png",img4 );

    QString img5 ;
    img5 = path+"/apply.png";
    QFile::copy(":/resources/apply.png",img5 );

    QString img6 ;
    img6 = path+"/arrow-left-01.png";
    QFile::copy(":/resources/arrow-left-01.png",img6 );

    QString img7 ;
    img7 = path+"/arrow-right-01.png";
    QFile::copy(":/resources/arrow-right-01.png",img7 );

    QString img8 ;
    img8 = path+"/aya_no.svg";
    QFile::copy(":/resources/aya_no.svg",img8 );

    QString img10 ;
    img10 = path+"/bookmark.png";
    QFile::copy(":/resources/bookmark.png",img10 );

    QString img11 ;
    img11 = path+"/clock.png";
    QFile::copy(":/resources/clock.png",img11 );

    QString img12 ;
    img12 = path+"/color.png";
    QFile::copy(":/resources/color.png",img12 );

    QString img13 ;
    img13 = path+"/del.png";
    QFile::copy(":/resources/del.png",img13 );

    QString img14 ;
    img14 = path+"/fb.png";
    QFile::copy(":/resources/fb.png",img14 );

    QString img15 ;
    img15 = path+"/fff.png";
    QFile::copy(":/resources/fff.png",img15 );

    QString img16 ;
    img16 = path+"/help.png";
    QFile::copy(":/resources/help.png",img16 );

    QString img17 ;
    img17 = path+"/hide.png";
    QFile::copy(":/resources/hide.png",img17 );

    QString img18 ;
    img18 = path+"/icon-small.png";
    QFile::copy(":/resources/icon-small.png",img18 );

    QString img19 ;
    img19 = path+"/icon.png";
    QFile::copy(":/resources/icon.png",img19 );

    QString img20 ;
    img20 = path+"/me.jpg";
    QFile::copy(":/resources/me.jpg",img20 );

    QString img21 ;
    img21 = path+"/mix_document.png";
    QFile::copy(":/resources/mix_document.png",img21 );

    QString img22 ;
    img22 = path+"/page_num.svg";
    QFile::copy(":/resources/page_num.svg",img22 );

    QString img23 ;
    img23 = path+"/search.png";
    QFile::copy(":/resources/search.png",img23 );


// Call Ring and run the Application

    RingState *pRingState;

    pRingState = ring_state_init();

    char** files;
    files = (char **) malloc(2 * sizeof(char*));
    for (size_t i = 0; i < 2; i += 1)
        files[i] = (char *) malloc(255 * sizeof(char));
    strcpy(files[0],"ring");
    strcpy(files[1],path2.toStdString().c_str());

    ring_state_main(2,files);

    // Free Memory and delete the application files
    // Here we don't delete the library files (We keep the files that will not be changed)

    ring_state_delete(pRingState);

    free(files[1]);
    free(files[0]);
    free(files);

    char mytarget[100];
    sprintf(mytarget,"%s%s",path.toStdString().c_str(),"/test.ring");
    QFile myfile;
    myfile.setFileName(mytarget);
    myfile.setPermissions(QFile::ReadOther | QFile::WriteOther);
    myfile.remove();

    return 0;

}




