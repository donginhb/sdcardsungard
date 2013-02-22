#ifndef __InitCardFrameImpl__
#define __InitCardFrameImpl__

/**
@file
Subclass of InitCardFrame, which is generated by wxFormBuilder.
*/

#include "InitCardFrame.h"

//// end generated include
class InitCardThread;

/** Implementing InitCardFrame */
class InitCardFrameImpl : public InitCardFrame
{
private:
	bool m_PCDConnected;
	bool m_isAuth;
	InitCardThread* m_workThr;
	int InitKsCardLib();
	wxString getCardLibError(wxString &errmsg);
	bool StartWork();
	void StopWork();
	bool IsWork();
	void LogMsg(const wxString &msg);
protected:
	// Handlers for InitCardFrame events.
	void m_connPCDBtnOnButtonClick( wxCommandEvent& event );
	void m_connPCDBtnOnUpdateUI( wxUpdateUIEvent& event );
	void m_startBtnOnButtonClick( wxCommandEvent& event );
	void m_startBtnOnUpdateUI( wxUpdateUIEvent& event );
	void m_authBtnOnButtonClick( wxCommandEvent& event );
	void m_authBtnOnUpdateUI( wxUpdateUIEvent& event );
	void m_closeBtnOnButtonClick( wxCommandEvent& event );
	void m_closeBtnOnUpdateUI( wxUpdateUIEvent& event );

	//////////////////////////////////////////////////
	void m_OnInitOneCard( wxCommandEvent& event );
public:
	/** Constructor */
	InitCardFrameImpl( wxWindow* parent );
	//// end generated class members
	
};


class InitCardApp : public wxApp
{
private:
	InitCardFrame * m_frame;
public:
	InitCardApp();
	virtual ~InitCardApp();
	virtual bool OnInit();
	virtual int OnExit();

};

class InitCardThread : public wxThread
{
private:
	int doProcess();
	void SendFinishEvent(const wxString &cardPhyID);
public:
	InitCardThread();
	virtual ~InitCardThread();
	void* Entry();
	bool StartWork();
};
#endif // __InitCardFrameImpl__