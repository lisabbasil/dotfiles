{
    /*
    // Set up FW Lite for automatic loading of CMS libraries
    // and data formats.   As you may have other user-defined setup
    // in your rootlogon.C, the CMS setup is executed only if the CMS
    // environment is set up.

    // To load FW lite, export the LOADFWLITE variable in bash
    TString loadfwlite = getenv("LOADFWLITE");
    TString cmsswbase = getenv("CMSSW_BASE");

    if (cmsswbase.Length() > 0 && loadfwlite.Length() > 0) {
    //
    // The CMSSW environment is defined (this is true even for FW Lite)
    // so set up the rest.
    //
    cout << "Loading FW Lite setup." << endl;
    gSystem->Load("libFWCoreFWLite.so");
    //AutoLibraryLoader::enable();
    FWLiteEnabler::enable();
    gSystem->Load("libDataFormatsFWLite.so");
    gSystem->Load("libDataFormatsPatCandidates.so");
    gROOT->SetStyle("Plain");
    gSystem->Load("libRooFit");
    using namespace RooFit;
    }
    */
}
