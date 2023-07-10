class ApiConstant {
  static const baseUrl = "https://devapi.employeetrackingsolutions.com/";

  // --------------------------------- company portal --------------------------------------------------------

  static String userToken = '';
  static String profileImage = '';
  static String attendanceStatus = '';
  static bool isAttendance = false;
  static const companyLogin = 'company-login/';
  static const companyProfile = 'company/get-profile';
  static const companyAllEmployee = 'company/get-employee-list?show=500&';

  static const companyDepartment = 'company/department-list/';
  static const companyContacts = 'company/get-all-contact?show=500&';
  static const addCompanyContacts = 'company/add-contact/';
  static const companyAddContact = 'company/add-contact/';
  static const companyEditContact = 'company/edit-contact/';
  static const getCompanyOrder = 'company/get-all-order?show=500&';
  static const getCompanyTask = 'company/get-all-task?show=500&';
  static const getCompanyEstimate = 'company/get-all-estimate?show=500&';
  static const companyAddOrder = 'company/add-order/';
  static const companyEditOrder = 'company/edit-order/';
  static const companyDeleteOrder = 'company/delete-order/';
  static const companyEstimateForOrder = 'company/get-orders-estiment/';
  static const companyEmployeeList = 'company/get_employee_list.php';
  static const companyDeleteEstimate = 'company/delete-estimate/';
  static const companyGetContactForEstimate = 'company/get-estimate-contacts/';
  static const companyAddEstimate = 'company/add-estimate/';
  static const companyAddNote = 'company/add-notes/';
  static const deleteCompanyEmployee = 'company/get-profile';
  static const companyNoteList = 'company/get-all-notes?show=500&';
  static const companyAddTask = 'company/add-task/';
  static const companyEditTask = 'company/edit-task/';
  static const companyDeleteTask = 'company/delete-task/';
  static const companyDeleteNote = 'company/delete-notes/';
  static const companyEditNote = 'company/edit-notes/';
  static const companyViewAttendance = 'company/view-attendance/';
  static const companyViewHours = 'company/view-hours-employee/';
  static const companyViewImage = 'company/view-image-employee/';
  static const companyViewMap = 'company/view-map-employee/';
  static const sendLocationRequest =
      'company/send_live_location_request_employee.php?id=';
  static const sendCallRequest =
      'company/send_call_for_attendance_request.php?id=';
  static const companyHoldAccessEmployee =
      'company/hold_access_employee.php?id=';
  static const companyDeleteContact = 'company/delete-contact/';
  static const companyDeleteEmployee = 'company/delete-employee-company?id=';
  static const companyEmployeeDetail = 'company/get-employee-details/?id=';
  static const companyEditEmployee = 'company/edit-employee/';
  static const companyEditDepartment = 'company/edit-department/';
  static const companyUpdateProfile = 'company/update-company-details/';
  static const companyChangePassword = 'company/reset-password/';
  static const companyAllInvoice = 'company/get-all-invoice?show=500&';
  static const companyDeleteInvoice = 'employee/delete-invoice/';
  static const companyInvoiceFor = 'company/get-invoice-estiment/';
  static const companyTaskOrder = 'company/get-task-orders/';
  static const companyCustomerType = 'company/get-customer-type';
  static const companyRegister = 'register-company/';
  static const companyGetDepartmentDetail = 'company/edit-departments/';
  static const companyDeleteDepartment = 'company/delete-department/';
  static const companyAddDepartment = 'company/add-department';
  static const cmpAcceptHourRequest = 'company/accept-fix-hrs-request';
  static const cmpRejectHourRequest = 'company/reject-fix-hrs-request';
  static const companyFixHourRequest =
      'company/view-fix-hrs-request?show=500&searchName=&page=';
  static const companyAllReport = 'company/get-all-report/?show=500&';
  static const companyMonthlyReport = 'company/get-monthly-report/';
  static const companyYearlyReport = 'company/get-yearly-report/';
  static const companyTotalEmployee = 'company/get-total-employee/';
  static const companyTotalDepartment = 'company/get-total-department/';
  static const companyNotification = 'company/get-notification/';
  static const companyApprovals = 'company/view-approvals';
  static const companyAddEmployee = 'company/add-employee';
  static const companyAddEvent = 'company/add-event/';
  static const companyInbox = 'company/get_employee_list.php';
  static const companySubscription = 'company/send-subscription-aggrement';
  static const companyAcceptProfileRequest =
      'company/accept-emp-profile-request';
  static const companyRejectProfileRequest =
      'company/reject-emp-profile-request';
  static const companyEmployeeLiveLocation =
      'company/view-live-location-employee?id=';
  static const companyMessage = 'company/get-message/';
  static const companyEditAttendanceList = 'company/view-edit-attendence/';
  static const companyAgencyRequest =
      'company/get-agency-or-agent-request-list/';
  static const companyAcceptAgencyRequest = 'company/reject-agency-request/';

  static const companyDeleteViewAttendance =
      'company/delete-view-attendence//?id=';
  static const companyDeleteAttendance = 'company/delete-attendence/?id=';
  static const companyAddInvoice = 'company/add-invoice/';
  static const companyEditInvoice = 'company/edit-invoice/';
  static const companySendMessage = 'company/send-message/';
  static const companyDownloadInvoice = 'company/download-invoice/';
  static const companyDownloadEstimate = 'company/download-estimate/';

  //today

  static const companyGetContactInvoice = 'company/contact_invoice_list';
  static const companyContactsList = 'company/get-all-contact';
  static const companyAddInvoiceForContact = 'company/add_contact_invoice';
  static const companyContactInvoice = 'company/delete_contact_invoice/';
  static const companyEditInvoiceForContact = 'company/edit_contact_invoice';

  // --------------------------------- employee portal  --------------------------------------------------------

  static const employeeLogin = 'employee-login/';
  static const employeeSendHourRequest =
      'employee/send-fix-hours-request-employee/';
  static const employeeGetHourRequest =
      'employee/get-hour-request-list-employee?show=10&';
  static const employeeAttendanceHistory =
      'employee/attendance-history-employee?show=10&';
  static const employeeAddAttendance = 'employee/add-attendance-employee/';
  static const employeeContactList = 'employee/view-contact-list?show=500&';
  static const employeeContactListForInvoice = 'employee/view-contact-list';

  static const employeeViewInvoice = 'employee/view-invoice-lists?show=500&';
  static const employeeEstimateList = 'employee/view-estimate-lists?show=500&';
  static const employeeOrderList = 'employee/view-orders-lists?show=500&';
  static const employeeTaskList = 'employee/view-task-list?show=500&';
  static const employeeNoteList = 'employee/view-notes-list?show=500&';
  static const employeeViewEvent =
      'employee/view-event-list?show=500&searchName&page=';

  static const employeeAddContact = 'employee/add-contact';
  static const employeeEditContact = 'employee/edit-contact/';
  static const employeeDeleteContact = 'employee/delete-contact/';
  static const employeeAddEstimate = 'employee/add-estimate';
  static const employeeEditEstimate = 'employee/edit-estimate/';
  static const employeeEstimateContact = 'employee/get-estimate-contacts/';
  static const employeeAddNote = 'employee/add-notes';
  static const employeeEditNote = 'employee/edit-note/';
  static const employeeDeleteInvoice = 'employee/delete-invoice/';
  static const employeeAddInvoice = 'employee/add-invoice';
  static const employeeAddInvoiceForContact = 'employee/add_contact_invoice';
  static const employeeEditInvoiceForContact = 'employee/edit_contact_invoice';

  static const employeeGetContactInvoice = 'employee/contact_invoice_list';
  static const employeeContactInvoice = 'employee/delete_contact_invoice/';

  static const employeeEditInvoice = 'employee/edit-invoice/';
  static const employeeGetEstimateOrder = 'employee/get-orders-estiment';
  static const employeeAddOrder = 'employee/add-orders';
  static const employeeEditOrder = 'employee/edit_orders.php/?id=';
  static const employeeGetImage = 'employee/view-image-employee?date=';
  static const employeeGetMap = 'employee/view-map-employee?date=';
  static const employeeNotification = 'employee/get-notification/';

  static const employeeGetOrderForTaskList = 'employee/get-task-orders';
  static const employeeAddTask = 'employee/add-task';
  static const employeeEditTask = 'employee/edit-task/';
  static const employeeDeleteTask = 'employee/delete-task/';
  static const employeeDeleteEstimate = 'employee/delete-estimate/';
  static const employeeDeleteNote = 'employee/delete-note/';
  static const employeeDeleteOrder = 'employee/delete_order.php?id=';
  static const employeeAddEvent = 'employee/add-event';
  static const employeeStartSharingLocation =
      'employee/start-share-live-location';
  static const employeeStopSharingLocation =
      'employee/stop-share-live-location';
  static const employeeChangePassword = 'employee/change-password/';
  static const employeeViewProfileDetails = 'employee/view-profile-details/';
  static const employeeUpdateProfileDetails =
      'employee/update-profile-details/';
  static const employeeUpdateProfilePicture =
      'employee/update-profile-picture/';
  static const employeeCheckAttendanceStatus = 'employee/check_attendance';
  static const employeeMessage = 'employee/get-message-list/';
  static const employeeSendMessage = 'employee/send-message/';
  static const employeeEstimateDownload = 'employee/download-estimate/';
  static const employeeInvoiceDownload = 'employee/download-invoice/';
  static const employeeInvoiceOrder = 'employee/download-emp-change-order/';

  // --------------------------------- sales portal --------------------------------------------------------

  static const salesLogin = 'sales-login/';
  static const salesDeleteAgent = 'SALES/delete-agent/';
  static const salesAgent =
      'SALES/view-all-agent?show=10&startdate=&enddate=&searchName=&page=';
  static const agencyRegister = 'register-agency-or-agent/';
}
