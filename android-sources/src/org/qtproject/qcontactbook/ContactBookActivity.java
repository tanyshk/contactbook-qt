package org.qtproject.qcontactbook;

import android.net.Uri;
import android.content.Context;
import android.content.Intent;

import android.content.ContentResolver;
import android.provider.ContactsContract;
import android.database.Cursor;
import android.content.ContentValues;
import android.util.Base64;
import android.net.Uri;
import android.content.ContentProviderOperation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.lang.StringBuilder;
import android.provider.ContactsContract.RawContacts;
import android.accounts.AccountManager;
import android.content.ContentProviderResult;
import android.content.ContentUris;

import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.app.ActionBar;
import android.view.ViewConfiguration;

public class ContactBookActivity extends org.qtproject.qt5.android.bindings.QtActivity
{

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR);
        //requestWindowFeature(Window.FEATURE_ACTION_BAR);

        super.onCreate(savedInstanceState);
    }

    private static ContactBookActivity m_instance;

    public ContactBookActivity()
    {
        m_instance = this;
    }

    public static void call(String number)
    {
        Intent callIntent = new Intent(Intent.ACTION_CALL);

        callIntent.setData(Uri.parse("tel:" + number.replaceAll("[^0-9|\\+]", "")));
        m_instance.startActivity(callIntent);
    }

    private static void addContact(String name, String number, String number2, String filial, String title)
    {

 String DisplayName = name;
 String MobileNumber = number;
 String WorkNumber = number2;
 String company = filial;
 String jobTitle = title;
 int id = 0;

 ArrayList < ContentProviderOperation > ops = new ArrayList < ContentProviderOperation > ();

 ops.add(ContentProviderOperation.newInsert(
 ContactsContract.RawContacts.CONTENT_URI)
     .withValue(ContactsContract.RawContacts.ACCOUNT_TYPE, null)
     .withValue(ContactsContract.RawContacts.ACCOUNT_NAME, null)
     .build());

 //------------------------------------------------------ Names
 if (DisplayName != null) {
     ops.add(ContentProviderOperation.newInsert(
     ContactsContract.Data.CONTENT_URI)
         .withValueBackReference(ContactsContract.Data.RAW_CONTACT_ID, id)
         .withValue(ContactsContract.Data.MIMETYPE,
     ContactsContract.CommonDataKinds.StructuredName.CONTENT_ITEM_TYPE)
         .withValue(
     ContactsContract.CommonDataKinds.StructuredName.DISPLAY_NAME,
     DisplayName).build());
 }

 //------------------------------------------------------ Mobile Number
 if (MobileNumber != null) {
     ops.add(ContentProviderOperation.
     newInsert(ContactsContract.Data.CONTENT_URI)
         .withValueBackReference(ContactsContract.Data.RAW_CONTACT_ID, id)
         .withValue(ContactsContract.Data.MIMETYPE,
     ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE)
         .withValue(ContactsContract.CommonDataKinds.Phone.NUMBER, MobileNumber)
         .withValue(ContactsContract.CommonDataKinds.Phone.TYPE,
     ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE)
         .build());
 }

  //------------------------------------------------------ Work Numbers
 if (WorkNumber != null) {
     ops.add(ContentProviderOperation.newInsert(ContactsContract.Data.CONTENT_URI)
         .withValueBackReference(ContactsContract.Data.RAW_CONTACT_ID, id)
         .withValue(ContactsContract.Data.MIMETYPE,
     ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE)
         .withValue(ContactsContract.CommonDataKinds.Phone.NUMBER, WorkNumber)
         .withValue(ContactsContract.CommonDataKinds.Phone.TYPE,
     ContactsContract.CommonDataKinds.Phone.TYPE_WORK)
         .build());
 }

 //------------------------------------------------------ Organization
 if (!company.equals("") && !jobTitle.equals("")) {
     ops.add(ContentProviderOperation.newInsert(ContactsContract.Data.CONTENT_URI)
         .withValueBackReference(ContactsContract.Data.RAW_CONTACT_ID, id)
         .withValue(ContactsContract.Data.MIMETYPE,
     ContactsContract.CommonDataKinds.Organization.CONTENT_ITEM_TYPE)
         .withValue(ContactsContract.CommonDataKinds.Organization.COMPANY, company)
         .withValue(ContactsContract.CommonDataKinds.Organization.TYPE, ContactsContract.CommonDataKinds.Organization.TYPE_WORK)
         .withValue(ContactsContract.CommonDataKinds.Organization.TITLE, jobTitle)
         .withValue(ContactsContract.CommonDataKinds.Organization.TYPE, ContactsContract.CommonDataKinds.Organization.TYPE_WORK)
         .build());
 }



 // Asking the Contact provider to create a new contact
 try {
     ContentProviderResult[] res = m_instance.getContentResolver().applyBatch(ContactsContract.AUTHORITY, ops);
     long contactId = ContentUris.parseId(res[0].uri);
     //Log.d("123", "inserted id = " + contactId);
     //return contactId;
 } catch (Exception e) {
     e.printStackTrace();
     //Toast.makeText(myContext, "Exception: " + e.getMessage(), Toast.LENGTH_SHORT).show();
     //Log.w("123", "Exception: " + e.getMessage());
 }
    //return -1;
    }
}
